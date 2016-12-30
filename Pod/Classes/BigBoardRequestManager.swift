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

class BigBoardRequestManager: NSObject {

    fileprivate static var _manager:Alamofire.SessionManager?
    class var manager:Alamofire.SessionManager {
        get {
            if _manager == nil {
                let configuration = URLSessionConfiguration.background(withIdentifier: "(NSBundle.mainBundle().bundleIdentifier).background")
                configuration.timeoutIntervalForRequest = 30.0   // How long to wait on server's response
                configuration.timeoutIntervalForResource = 30.0  // How long to wait for client to make request
                _manager = Alamofire.SessionManager(configuration: configuration)
                _manager!.startRequestsImmediately = true
            }
            
            return _manager!
        }
    }
    
    /*
        Returns a basic request that each custom request should use. Validates it to make sure the response status code 
        is in the 200-299 range.
    */
    
    fileprivate class func generalRequest(_ method:Alamofire.HTTPMethod, urlString:String, parameters:[String: AnyObject]? = nil) -> DataRequest {
        return manager.request(urlString, method: method, parameters: parameters).validate()
    }
    
    
    /*
        Unwraps the success callback and if the success callback exists, it calls it and passes back the stock that was
        just mapped.
    */
    
    fileprivate class func callSuccessCallback(success:((BigBoardStock) -> Void)?, stock:BigBoardStock){
        if let success = success {
            success(stock)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    fileprivate class func callErrorCallback(failure:((BigBoardError) -> Void)?, error:NSError){
        let bigBoardError = BigBoardError(nsError: error)
        if let failure = failure {
            failure(bigBoardError)
        }
    }
    
    
    /*
        Unwraps the failure callback and if the failure callback exists, it calls it and passes back a BigBoardError object
        with the appropriate message.
    */
    
    fileprivate class func callErrorCallback(failure:((BigBoardError) -> Void)?, bigBoardError:BigBoardError){
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
    
    class func mapBigBoardStock(symbol:String, success:((BigBoardStock) -> Void)?, failure:((BigBoardError) -> Void)?) -> DataRequest? {
        
        let urlString = BigBoardUrlCreator.urlForStockSymbol(symbol: symbol)
        
        return generalRequest(.get, urlString: urlString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:DataResponse<BigBoardStock>) in
            switch response.result {
                case .success:
                    let stock = response.result.value!
                    if stock.isReal() {
                        callSuccessCallback(success: success, stock: stock)
                    } else {
                        let bigBoardError = BigBoardError(invalidSymbol: symbol)
                        callErrorCallback(failure: failure, bigBoardError:bigBoardError)
                    }
                case .failure(let error):
                    callErrorCallback(failure: failure, error: error as NSError)
            } 
        })
    }
    
    
    /*
        Maps multiple BigBoardStock objects with the provided symbols.
        @param symbols: The symbols of each stock you are wanting to map
        @param success: The callback that is called if all of the the mappings were successfull
        @param failure: The callback that is called if the mapping failed or if one or more of the stock symbols provided were not valid
     */
    
    class func mapBigBoardStocks(symbols:[String], success:(([BigBoardStock]) -> Void)?, failure:((BigBoardError) -> Void)?) -> DataRequest? {
        
        let urlString = BigBoardUrlCreator.urlForStockSymbols(symbols: symbols)
        
        /*  If symbols array only contains one symbol, then we need to call the mapBigBoardStock function because Yahoo
            will return just a single object, not an array with a single value, thus ObjectMapper can not perform the
            mapping.
        */
        if symbols.count > 1 {
            
            return generalRequest(.get, urlString: urlString).responseArray(queue: nil, keyPath: "query.results.quote", completionHandler: { (response:DataResponse<[BigBoardStock]>) in
                switch response.result {
                    case .success:
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
                    
                    case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
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
    
    class func mapHistoricalDataForStock(stock:BigBoardStock?, dateRange:BigBoardHistoricalDateRange, success:@escaping (([BigBoardHistoricalData]) -> Void), failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        
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
                    return generalRequest(.get, urlString: urlString).responseArray(queue: nil, keyPath: "query.results.quote", completionHandler: { (response:DataResponse<[BigBoardHistoricalData]>) in
                        switch response.result {
                        case .success: success(response.result.value!)
                        case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
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
    
    fileprivate class func mapHistoricalDataItem(_ urlString:String, success:@escaping (([BigBoardHistoricalData]) -> Void), failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return generalRequest(.get, urlString: urlString).responseObject(queue: nil, keyPath: "query.results.quote", mapToObject: nil, completionHandler: { (response:DataResponse<BigBoardHistoricalData>) in
            switch response.result {
                case .success: success([response.result.value!])
                case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
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
    
    class func mapChartDataModuleForStockWithSymbol(symbol:String, range:BigBoardChartDataModuleRange, success:@escaping ((BigBoardChartDataModule) -> Void), failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        let urlString = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: symbol, range: range)
        return generalRequest(.get, urlString: urlString).responseData(queue: nil) { (response:DataResponse<Data>) in
            
            switch response.result {
                case .success:
                    
                    /*
                        Since the JSON is returned with a JSONP callback, we must do the following steps:
                        1. Convert the data into a JSON string
                        2. Remove the JSONP callback from the JSON. In this case, we want to remove 'BigBoard(' from the beginning
                           of the JSON string and ')' at the end of the JSON string
                        3. Turn the trimmedJsonString into NSData
                        4. Turn that NSData into a JSON object
                        5. Initialize a BigBoardChartDataModule object and pass in the formattedJson object into the mapping
                    */
                    
                    let jsonString:String = String(data: response.data!, encoding: .utf8)!
                    var trimmedJsonString:String = jsonString.substring(from: "BigBoard(".endIndex)
                    trimmedJsonString = trimmedJsonString.substring(to: trimmedJsonString.index(trimmedJsonString.endIndex, offsetBy: -1))
                    
                    let trimmedJsonStringData:Data = trimmedJsonString.data(using: .utf8)!
                    let formattedJson = try? JSONSerialization.jsonObject(with: trimmedJsonStringData, options: .mutableContainers)
                    
                    let module = BigBoardChartDataModule(map: Map(mappingType: .fromJSON, JSON: formattedJson as! [String : Any]))!
                    success(module)
                
                case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
            }
        }
    }
    
    /*
        Maps BigBoardSearchResultStock objects based on the provided search term.
        @param searchTerm: The search term to use to perform the mapping
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    class func stocksContainingSearchTerm(searchTerm:String, success:@escaping (([BigBoardSearchResultStock]) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        
        let urlString = BigBoardUrlCreator.urlForAutoCompleteSearch(searchTerm: searchTerm)
        
        return generalRequest(.get, urlString: urlString).responseArray(queue: nil, keyPath: "ResultSet.Result", completionHandler: { (response:DataResponse<[BigBoardSearchResultStock]>) in
            
            switch response.result {
                case .success: success(response.result.value!)
                case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
            }
        })
    }
    
    
    /*
        Maps the 25 most recent items for an RSS feed for the given stock symbol.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    class func rssFeedForStockWithSymbol(symbol:String, success:@escaping ((BigBoardRSSFeed) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return rssFeedForStocksWithSymbols(symbols: [symbol], success: success, failure: failure)
    }
    
    
    /*
        Maps the 25 most recent items for an RSS feed for the given stock symbols as one feed. There is no way to distinguish
        which items goes with which symbol. This is a limitation for. this particular Yahoo API request.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
     */
    
    class func rssFeedForStocksWithSymbols(symbols:[String], success:@escaping ((BigBoardRSSFeed) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        
        let urlString:String = BigBoardUrlCreator.urlForRSSFeed(symbols: symbols)
        let parameters: [String : AnyObject] = ["rss_url" : urlString as AnyObject]
        
        return generalRequest(.get, urlString: "http://rss2json.com/api.json", parameters: parameters).responseObject(completionHandler: { (response:DataResponse<BigBoardRSSFeed>) in
            switch response.result {
                case .success: success(response.result.value!)
                case .failure(let error): callErrorCallback(failure: failure, error: error as NSError)
            }
        })
    }
}

