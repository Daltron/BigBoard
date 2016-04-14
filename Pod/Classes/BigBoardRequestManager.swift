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
    
    class func mapBigBoardStock(symbol symbol:String, success:((BigBoardStock) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request {
        let queryString = BigBoardQueryCreator.queryForStockSymbol(symbol: symbol)
        return generalRequest(.GET, urlString: queryString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:Response<BigBoardStock, NSError>) in
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
    
    class func mapBigBoardStocks(symbols symbols:[String], success:(([BigBoardStock]) -> Void)?, failure:((BigBoardError) -> Void)?) -> Request {
        let queryString = BigBoardQueryCreator.queryForStockSymbols(symbols: symbols)
        return generalRequest(.GET, urlString: queryString).responseArray(queue: nil, keyPath: "query.results.quote", completionHandler: { (response:Response<[BigBoardStock], NSError>) in
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
    }

}
