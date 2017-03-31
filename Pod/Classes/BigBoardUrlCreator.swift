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

import Foundation

private enum BigBoardQueryType : String {
    case Symbol = "SELECT * FROM yahoo.finance.quotes WHERE symbol IN"
    case HistoricalData = "SELECT * FROM yahoo.finance.historicaldata WHERE symbol IN"
}

class BigBoardUrlCreator: NSObject {

    // MARK: Base YQL URL Strings
    fileprivate static let YQL_URL_PREFIX:String = "https://query.yahooapis.com/v1/public/yql?q="
    fileprivate static let YQL_URL_SUFFIX:String = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    
    /*  Returns a query for a single stock with the provided symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
    */
    
    fileprivate class func queryForStockSymbol(symbol:String, queryType:BigBoardQueryType) -> String {
        return queryForStockSymbols(symbols: [symbol], queryType: queryType)
    }
    
    
    /*  Returns a query for multiple stocks with the given symbols
        @param symbols: An array of stock symbols for the desired stocks. Google -> GOOG, Tesla -> TSLA, etc...
    */
    
    fileprivate class func queryForStockSymbols(symbols:[String], queryType:BigBoardQueryType) -> String {
        var symbolsArray = symbols
        for symbol in symbolsArray {
            symbolsArray[symbols.index(of: symbol)!] = "'\(symbol)'".uppercased()
        }
        
        let symbolsString = symbolsArray.joined(separator: ",")
        return percentEscapedQuery(query: "\(queryType.rawValue) (\(symbolsString))")
    }
    
    
    /*  Returns a URL for a single stock with the provided symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
    */
    
    class func urlForStockSymbol(symbol:String) -> String {
        return urlForStockSymbols(symbols: [symbol])
    }
    
    
    /*  Returns a URL for multiple stocks with the given symbols
        @param symbols: An array of stock symbols for the desired stocks. Google -> GOOG, Tesla -> TSLA, etc...
    */
    
    class func urlForStockSymbols(symbols:[String]) -> String {
        let symbolsQuery = queryForStockSymbols(symbols: symbols, queryType: .Symbol)
        return "\(YQL_URL_PREFIX)\(symbolsQuery)\(YQL_URL_SUFFIX)"
    }
    
    
    /*  Returns a URL for historical data for a given stock symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
        @param startDate: The date you want the historical data to start from
        @param endDate: The date you want the historical data to end at
    */
    
    class func urlForHistoricalDataWithStockSymbol(symbol:String, dateRange:BigBoardHistoricalDateRange) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDateString = dateFormatter.string(from: dateRange.startDate as Date)
        let endDateString = dateFormatter.string(from: dateRange.endDate as Date)
        
        let dateQuery = percentEscapedQuery(query: " AND startDate= \"\(startDateString)\" AND endDate= \"\(endDateString)\"")

        let symbolsQuery = queryForStockSymbol(symbol: symbol, queryType: .HistoricalData)
        let completedUrl = "\(YQL_URL_PREFIX)\(symbolsQuery)\(dateQuery)\(YQL_URL_SUFFIX)"
 
        return completedUrl
    }
    
    /*  Returns a URL for a stock with the provided symbol and range
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
        @param range: The range of the chart data you want to map
    */
    
    class func urlForChartDataModuleWithSymbol(symbol:String, range:BigBoardChartDataModuleRange) -> String {
        return "https://chartapi.finance.yahoo.com/instrument/1.0/\(symbol)/chartdata;type=quote;range=\(range.rawValue)/json?callback=BigBoard"
    }
    
    
    /*  Returns a URL for an autocomplete search containg the given search term
        @param searchTerm: The term you are looking to contain
    */
    
    class func urlForAutoCompleteSearch(searchTerm:String) -> String {
        return "https://autoc.finance.yahoo.com/autoc?query=\(percentEscapedQuery(query: searchTerm))&region=2&lang=en"
    }
    
    /*
        Returns a URL for a graph image for a given stock
        @param stock: Stock you want to load the graph for
        @param timelineInMonths: How far in months you want the data of the graph image to display
        @param movingAverageTrendlineDays: Trendlines in days you want for the data of the graph image. For example, if you specify [5,50],
                                           then the image that is loaded will have both a 5 day moving average trendline and a 50 day moving
                                           average trendline.
    */
    
    class func urlForGraphImage(stock:BigBoardStock, timelineInMonths:Int, movingAverageTrendlineDays:[Int]?) -> String {
        
        let trendlines:NSMutableArray = []
        if let movingAverageTrendlineDays = movingAverageTrendlineDays {
            for trendline in movingAverageTrendlineDays {
                trendlines.add("m\(trendline)")
            }
        }
        
        return "https://chart.finance.yahoo.com/z?s=\(stock.symbol!)&t=\(timelineInMonths)m&q=l&l=on&z=s&p=\(trendlines.componentsJoined(by: ","))"
    }
    
    class func urlForRSSFeed(symbol:String) -> String {
        return urlForRSSFeed(symbols: [symbol])
    }
    
    class func urlForRSSFeed(symbols:[String]) -> String {
        let symbolsString = NSMutableArray(array: symbols).componentsJoined(by: ",")
        return "https://feeds.finance.yahoo.com/rss/2.0/headline?s=\(symbolsString)&region=US&lang=en-US&format=json"
    }
    
    /*  Returns a url string that is percent escaped encoded
        @param query: Any query that needs to be percent escaped encoded
    */
    
    fileprivate class func percentEscapedQuery(query:String) -> String {
        return query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
}
