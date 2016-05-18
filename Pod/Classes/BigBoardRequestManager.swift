//
//  BigBoardRequestManager.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Timepiece


class BigBoardRequestManager: NSObject {

    private static var _manager:Alamofire.Manager?
    class var manager:Alamofire.Manager {
        get {
            if _manager == nil {
                let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("(NSBundle.mainBundle().bundleIdentifier).background")
                _manager = Alamofire.Manager(configuration: configuration)
                _manager!.startRequestsImmediately = true
            }
            
            return _manager!
        }
    }
    
    class func generalRequest(method:Alamofire.Method, urlString:String) -> Request {
        return manager.request(method, urlString, parameters: nil, headers: nil).validate()
    }
    
    class func callSuccessCallback(success success:((BigBoardStock) -> Void)?, stock:BigBoardStock){
        if let success = success {
            success(stock)
        }
    }
    
    class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, error:NSError){
        let bigBoardError = BigBoardError(nsError: error)
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, bigBoardError:BigBoardError){
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    class func mapBigBoardStock(symbol symbol:String, success:((BigBoardStock) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request? {
        
        let urlString = BigBoardQueryCreator.urlForStockSymbol(symbol: symbol)
        
        return generalRequest(.GET, urlString: urlString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:Response<BigBoardStock, NSError>) in
            switch response.result {
                case .Success:
                    let stock = response.result.value!
                    if stock.isReal() {
                        callSuccessCallback(success: success, stock: stock)
                    } else {
                        let bigBoardError = BigBoardError(invalidSymbol: symbol)
                        callErrorCallback(failure: failure, bigBoardError:bigBoardError)
                    }
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            } 
        })
    }
    
    class func mapBigBoardStocks(symbols symbols:[String], success:(([BigBoardStock]) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request? {
        
        let urlString = BigBoardQueryCreator.urlForStockSymbols(symbols: symbols)
        
        /*  If symbols array only contains one symbol, then we need to call the mapBigBoardStock function because Yahoo
            will return just a single object, not an array with a single value, thus ObjectMapper can not perform the
            mapping.
        */
        if symbols.count > 1 {
            
            return generalRequest(.GET, urlString: urlString).responseArray(queue: nil, keyPath: "query.results.quote", completionHandler: { (response:Response<[BigBoardStock], NSError>) in
                switch response.result {
                    case .Success:
                        let stocks = response.result.value!
                        let invalidSymbols = BigBoardStock.invalidSymbolsForStocks(stocks: stocks)
                        if invalidSymbols.isEmpty {
                            if let success = success {
                                success(response.result.value!)
                            }
                        } else {
                            let bigBoardError = BigBoardError(invalidSymbols: invalidSymbols)
                            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
                        }
                    
                    case .Failure(let error): callErrorCallback(failure: failure, error: error)
                }
            })

        } else {
            return mapBigBoardStock(symbol: symbols.first!, success: { (stock:BigBoardStock) in
                if let success = success {
                    success([stock])
                }
            }, failure: failure)
        }
    }
    
    class func mapHistoricalDataForStock(stock stock:BigBoardStock?, startDate:NSDate, endDate:NSDate, success:(([BigBoardHistoricalData]) -> Void), failure:(BigBoardError) -> Void) -> Request? {
        
        if startDate >= NSDate.today() || endDate >= NSDate.today() {
            let bigBoardError = BigBoardError(errorMessageType: .MappingFutureDate)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else if startDate > endDate {
            let bigBoardError = BigBoardError(errorMessageType: .StartDateGreaterThanEndDate)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else if startDate.isSameDayAsDate(endDate) && (startDate.weekday == 1 || startDate.weekday == 7) {
            let bigBoardError = BigBoardError(errorMessageType: .StockMarketIsClosedInGivenDateRange)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else if endDate.day == startDate.day + 1 && (startDate.weekday == 7 && endDate.weekday == 1) {
            let bigBoardError = BigBoardError(errorMessageType: .StockMarketIsClosedInGivenDateRange)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else {
            if let stockSymbol = stock?.symbol {
                let urlString = BigBoardQueryCreator.urlForHistoricalDataWithStockSymbol(symbol: stockSymbol, startDate: startDate, endDate: endDate)
                
                if startDate.isSameDayAsDate(endDate) {
                        return mapHistoricalDataItem(urlString, success: success, failure: failure)
                } else {
                    return generalRequest(.GET, urlString: urlString).responseArray(queue: nil, keyPath: "query.results.quote", completionHandler: { (response:Response<[BigBoardHistoricalData], NSError>) in
                        switch response.result {
                            case .Success: success(response.result.value!)
                            case .Failure(let error): callErrorCallback(failure: failure, error: error)
                        }
                    })
                }
                
            } else {
                let bigBoardError = BigBoardError(errorMessageType: .StockDoesNotExist)
                callErrorCallback(failure: failure, bigBoardError: bigBoardError)
            }
        }
        
        return nil
    }
    
    private class func mapHistoricalDataItem(urlString:String, success:(([BigBoardHistoricalData]) -> Void), failure:(BigBoardError) -> Void) -> Request? {
        return generalRequest(.GET, urlString: urlString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:Response<BigBoardHistoricalData, NSError>) in
            switch response.result {
                case .Success: success([response.result.value!])
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            }
        })
    }
}
