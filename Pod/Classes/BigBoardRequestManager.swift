/*
 
 The MIT License (MIT)
 Copyright (c) 2016 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/

import Alamofire
import ObjectMapper
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
    
    private class func generalRequest(method:Alamofire.Method, urlString:String, parameters:[String: AnyObject]? = nil) -> Request {
        return manager.request(method, urlString, parameters: parameters, headers: nil).validate()
    }
    
    
    /*
        Unwraps the success callback and if the success callback exists, it calls it and passes back the stock that was
        just mapped.
    */
    
    private class func callSuccessCallback(success success:((BigBoardStock) -> Void)?, stock:BigBoardStock){
        if let success = success {
            success(stock)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    private class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, error:NSError){
        let bigBoardError = BigBoardError(nsError: error)
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    private class func callErrorCallback(failure failure:((BigBoardError) -> Void)?, bigBoardError:BigBoardError){
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
    
    
    /*
        Maps chart data for the specified stock symbol for a given BigBoardChartDataModuleRange.
        @param symbol: The symbol of the stock you are wanting to map the chart data to
        @param range: The range of the chart data you want to map
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    class func mapChartDataModuleForStockWithSymbol(symbol symbol:String, range:BigBoardChartDataModuleRange, success:((BigBoardChartDataModule) -> Void), failure:(BigBoardError) -> Void) -> Request? {
        let urlString = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: symbol, range: range)
        return generalRequest(.GET, urlString: urlString).responseData(queue: nil) { (response:Response<NSData, NSError>) in
            
            switch response.result {
                case .Success:
                    
                    /*
                        Since the JSON is returned with a JSONP callback, we must do the following steps:
                        1. Convert the data into a JSON string
                        2. Remove the JSONP callback from the JSON. In this case, we want to remove 'BigBoard(' from the beginning
                           of the JSON string and ')' at the end of the JSON string
                        3. Turn the trimmedJsonString into NSData
                        4. Turn that NSData into a JSON object
                        5. Initialize a BigBoardChartDataModule object and pass in the formattedJson object into the mapping
                    */
                    
                    let jsonString = NSString(data: response.data!, encoding: NSUTF8StringEncoding)!
                    var trimmedJsonString = jsonString.substringFromIndex("BigBoard(".length + 1)
                    trimmedJsonString = trimmedJsonString.substringToIndex(trimmedJsonString.endIndex.advancedBy(-1))
                    
                    let trimmedJsonStringData = trimmedJsonString.dataUsingEncoding(NSUTF8StringEncoding)
                    let formattedJson = try? NSJSONSerialization.JSONObjectWithData(trimmedJsonStringData!, options: .MutableContainers) as! [String : AnyObject]
                    
                    let module = BigBoardChartDataModule(Map(mappingType: .FromJSON, JSONDictionary: formattedJson!))!
                    success(module)
                
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            }
        }
    }
    
    /*
        Maps BigBoardSearchResultStock objects based on the provided search term.
        @param searchTerm: The search term to use to perform the mapping
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    class func stocksContainingSearchTerm(searchTerm searchTerm:String, success:(([BigBoardSearchResultStock]) -> Void), failure:((BigBoardError) -> Void)) -> Request? {
        
        let urlString = BigBoardUrlCreator.urlForAutoCompleteSearch(searchTerm: searchTerm)
        
        return generalRequest(.GET, urlString: urlString).responseArray(queue: nil, keyPath: "ResultSet.Result", completionHandler: { (response:Response<[BigBoardSearchResultStock], NSError>) in
            
            switch response.result {
                case .Success: success(response.result.value!)
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            }
        })
    }
    
    
    /*
        Maps the 25 most recent items for an RSS feed for the given stock symbol.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    class func rssFeedForStockWithSymbol(symbol symbol:String, success:((BigBoardRSSFeed) -> Void), failure:((BigBoardError) -> Void)) -> Request? {
        return rssFeedForStocksWithSymbols(symbols: [symbol], success: success, failure: failure)
    }
    
    
    /*
        Maps the 25 most recent items for an RSS feed for the given stock symbols as one feed. There is no way to distinguish
        which items goes with which symbol. This is a limitation for. this particular Yahoo API request.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
     */
    
    class func rssFeedForStocksWithSymbols(symbols symbols:[String], success:((BigBoardRSSFeed) -> Void), failure:((BigBoardError) -> Void)) -> Request? {
        
        let urlString = BigBoardUrlCreator.urlForRSSFeed(symbols: symbols)
        let parameters = ["rss_url" : urlString]
        
        return generalRequest(.GET, urlString: "http://rss2json.com/api.json", parameters: parameters).responseObject(completionHandler: { (response:Response<BigBoardRSSFeed, NSError>) in
            switch response.result {
                case .Success: success(response.result.value!)
                case .Failure(let error): callErrorCallback(failure: failure, error: error)
            }
        })
    }
}

