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
    
    /*
        Returns a basic request that each custom request should use. Validates it to make sure the response status code 
        is in the 200-299 range.
    */
    
    class func generalRequest(method:Alamofire.Method, urlString:String) -> Request {
        return manager.request(method, urlString, parameters: nil, headers: nil).validate()
    }
    
    
    /*
        Unwraps the success callback and if the success callback exists, it calls it and passes back the stock that was
        just mapped.
    */
    
    class func callSuccessCallback(success success:((BigBoardStock) -> Void)?, stock:BigBoardStock){
        if let success = success {
            success(stock)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, error:NSError){
        let bigBoardError = BigBoardError(nsError: error)
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, bigBoardError:BigBoardError){
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    
    /*
        Maps a single BigBoardStock object with the provided symbol.
        @param symbol: The symbol of the stock you are wanting to map
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock symbol provided is not valid
    */
    
    class func mapBigBoardStock(symbol symbol:String, success:((BigBoardStock) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request? {
        
        let urlString = BigBoardUrlCreator.urlForStockSymbol(symbol: symbol)
        
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
    
    
    /*
        Maps multiple BigBoardStock objects with the provided symbols.
        @param symbols: The symbols of each stock you are wanting to map
        @param success: The callback that is called if all of the the mappings were successfull
        @param failure: The callback that is called if the mapping failed or if one or more of the stock symbols provided were not valid
     */
    
    class func mapBigBoardStocks(symbols symbols:[String], success:(([BigBoardStock]) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request? {
        
        let urlString = BigBoardUrlCreator.urlForStockSymbols(symbols: symbols)
        
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
    
    
    /*
        Maps BigBoardHistoricalData objects to the given stock in a given BigBoardHistoricalDateRange
        @param stock: The stock you are wanting to map the historical data to
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock provided is not valid
    */
    
    class func mapHistoricalDataForStock(stock stock:BigBoardStock?, dateRange:BigBoardHistoricalDateRange, success:(([BigBoardHistoricalData]) -> Void), failure:(BigBoardError) -> Void) -> Request? {
        
        if dateRange.isFutureDateRange() {
            let bigBoardError = BigBoardError(errorMessageType: .MappingFutureDate)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else if dateRange.startDateIsGreaterThanEndDate() {
            let bigBoardError = BigBoardError(errorMessageType: .StartDateGreaterThanEndDate)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else if dateRange.stockMarketIsClosedDuringRange() {
            let bigBoardError = BigBoardError(errorMessageType: .StockMarketIsClosedInGivenDateRange)
            callErrorCallback(failure: failure, bigBoardError: bigBoardError)
        } else {
            if stock!.isReal() {
                let urlString = BigBoardUrlCreator.urlForHistoricalDataWithStockSymbol(symbol: stock!.symbol!, dateRange: dateRange)
                
                if dateRange.startDate.isSameDayAsDate(dateRange.endDate) {
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
    
    
    /*
        Maps a single BigBoardHistoricalData object to the given stock for the given urlString. This method is only called
        if the startDate and endDate of a provided BigBoardHistoricalDateRange are on the same day.
        @param urlString: The string that is created by the BigBoardUrlCreator class
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
     */
    
    private class func mapHistoricalDataItem(urlString:String, success:(([BigBoardHistoricalData]) -> Void), failure:(BigBoardError) -> Void) -> Request? {
        return generalRequest(.GET, urlString: urlString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:Response<BigBoardHistoricalData, NSError>) in
            switch response.result {
                case .Success: success([response.result.value!])
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            }
        })
    }
}
