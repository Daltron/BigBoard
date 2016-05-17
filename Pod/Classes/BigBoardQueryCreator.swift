//
//  BigBoardQueryCreator.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

private enum BigBoardQueryType : String {
    case Symbol = "SELECT * FROM yahoo.finance.quotes WHERE symbol IN"
    case HistoricalData = "SELECT * FROM yahoo.finance.historicaldata WHERE symbol IN"
}

class BigBoardQueryCreator: NSObject {

    // MARK: Base YQL URL Strings
    private static let YQL_URL_PREFIX:String = "http://query.yahooapis.com/v1/public/yql?q="
    private static let YQL_URL_SUFFIX:String = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    /*  Returns a query for a single stock with the provided symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
    */
    private class func queryForStockSymbol(symbol symbol:String, queryType:BigBoardQueryType) -> String {
        return queryForStockSymbols(symbols: [symbol], queryType: queryType)
    }
    
    /*  Returns a query for multiple stocks with the given symbols
        @param symbols: An array of stock symbols for the desired stocks. Google -> GOOG, Tesla -> TSLA, etc...
    */
    private class func queryForStockSymbols(symbols symbols:[String], queryType:BigBoardQueryType) -> String {
        var symbolsArray = symbols
        for symbol in symbolsArray {
            symbolsArray[symbols.indexOf(symbol)!] = "'\(symbol)'".uppercaseString
        }
        
        let symbolsString = symbolsArray.joinWithSeparator(",")
        return percentEscapedQuery(query: "\(queryType.rawValue) (\(symbolsString))")
    }
    
    /*  Returns a URL for a single stock with the provided symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
    */
    class func urlForStockSymbol(symbol symbol:String) -> String {
        return urlForStockSymbols(symbols: [symbol])
    }
    
    /*  Returns a URL for multiple stocks with the given symbols
        @param symbols: An array of stock symbols for the desired stocks. Google -> GOOG, Tesla -> TSLA, etc...
    */
    class func urlForStockSymbols(symbols symbols:[String]) -> String {
        let symbolsQuery = queryForStockSymbols(symbols: symbols, queryType: .Symbol)
        return "\(YQL_URL_PREFIX)\(symbolsQuery)\(YQL_URL_SUFFIX)"
    }
    
    /*  Returns a URL for historical data for a given stock symbol
        @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
        @param startDate: The date you want the historical data to start from
        @param endDate: The date you want the historical data to end at
     */
    class func urlForHistoricalDataWithStockSymbol(symbol symbol:String, startDate:NSDate, endDate:NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let startDateString = dateFormatter.stringFromDate(startDate)
        let endDateString = dateFormatter.stringFromDate(endDate)
        
        let dateQuery = percentEscapedQuery(query: " AND startDate= \"\(startDateString)\" AND endDate= \"\(endDateString)\"")

        let symbolsQuery = queryForStockSymbol(symbol: symbol, queryType: .HistoricalData)
        let completedUrl = "\(YQL_URL_PREFIX)\(symbolsQuery)\(dateQuery)\(YQL_URL_SUFFIX)"
        
        return completedUrl
    }
    
    /*  Returns a url string that is percent escaped encoded
        @param query: Any query that needs to be percent escaped encoded
    */
    private class func percentEscapedQuery(query query:String) -> String {
        return query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
}
