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

open class BigBoard: NSObject {
    
    /*
        Calls the BigBoardRequestManager class to map a single BigBoardStock object with the provided symbol.
        @param symbol: The symbol of the stock you are wanting to map
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock symbol provided is not valid
    */
    
    open class func stockWithSymbol(symbol:String, success:@escaping ((BigBoardStock) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return BigBoardRequestManager.mapBigBoardStock(symbol: symbol, success: success, failure: failure)
    }
    
    
    /*
        Calls the BigBoardRequestManager class to map multiple BigBoardStock objects with the provided symbols.
        @param symbols: The symbols of each stock you are wanting to map
        @param success: The callback that is called if all of the the mappings were successfull
        @param failure: The callback that is called if the mapping failed or if one or more of the stock symbols provided were not valid
    */
    
    open class func stocksWithSymbols(symbols:[String], success:@escaping (([BigBoardStock]) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return BigBoardRequestManager.mapBigBoardStocks(symbols: symbols, success: success, failure: failure)
    }
    
    
    /*
        Calls the BigBoardRequestManager class to map BigBoardSearchResultStock objects based on the provided search term.
        @param searchTerm: The search term to use to perform the mapping
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    open class func stocksContainingSearchTerm(searchTerm:String, success:@escaping (([BigBoardSearchResultStock]) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return BigBoardRequestManager.stocksContainingSearchTerm(searchTerm: searchTerm, success: success, failure: failure)
    }
    
    
    /*
        Calls the BigBoardRequestManager class to map the 25 most recent items for an RSS feed for the given stock symbol.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    open class func rssFeedForStockWithSymbol(symbol:String, success:@escaping ((BigBoardRSSFeed) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return BigBoardRequestManager.rssFeedForStockWithSymbol(symbol: symbol, success: success, failure: failure)
    }
    
    
    /*
        Calls the BigBoardRequestManager class to map the 25 most recent items for an RSS feed for the given stock symbols as one feed.
        @param symbol: The symbol of the stock you want the RSS feed to be about
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed
    */
    
    open class func rssFeedForStocksWithSymbols(symbols:[String], success:@escaping ((BigBoardRSSFeed) -> Void), failure:@escaping ((BigBoardError) -> Void)) -> DataRequest? {
        return BigBoardRequestManager.rssFeedForStocksWithSymbols(symbols: symbols, success: success, failure: failure)
    }
}
