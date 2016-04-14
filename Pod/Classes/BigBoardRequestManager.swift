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
            
            return manager
        }
    }
    
    class func generalRequest(method:Alamofire.Method, urlString:String) -> Request {
        return manager.request(method, urlString, parameters: nil, headers: nil).validate()
    }
    
    class func mapBigBoardStock(symbol symbol:String, success:((BigBoardStock) -> Void)?, failure:((NSError) -> Void)?) -> Request {
        let queryString = BigBoardQueryCreator.queryForStockSymbol(symbol: symbol)
        return generalRequest(.GET, urlString: queryString).responseObject(completionHandler: { (response:Response<BigBoardStock, NSError>) in
            switch response.result {
                case .Success:
                    if let success = success {
                        success(response.result.value!)
                    }
                case .Failure(let error) :
                    if let failure = failure {
                        failure(error)
                    }
            }
        })
    }
}
