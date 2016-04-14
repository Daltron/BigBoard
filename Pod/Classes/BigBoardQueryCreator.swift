//
//  BigBoardQueryCreator.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class BigBoardQueryCreator: NSObject {

    // MARK: Base YQL Query Strings
    private static let YQL_QUERY_PREFIX:String = "http://query.yahooapis.com/v1/public/yql?q="
    private static let YQL_QUERY_SUFFIX:String = "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    
    // MARK: Custom YQL Query Strings
    private static let YQL_SYMBOL_QUERY:String = "SELECT * FROM yahoo.finance.quotes WHERE symbol IN"
    
    // Returns a query for a single stock with the provided symbol
    // @param symbol: The stock symbol of the desired stock. Google -> GOOG, Tesla -> TSLA, etc...
    class func queryForStockSymbol(symbol symbol:String) -> String {
        return queryForStockSymbols(symbols: [symbol])
    }
    
    // Returns a query for multiple stocks with the given symbols
    // @param symbols: An array of stock symbols for the desired stocks. Google -> GOOG, Tesla -> TSLA, etc...
    class func queryForStockSymbols(var symbols symbols:[String]) -> String {
        for symbol in symbols {
            symbols[symbols.indexOf(symbol)!] = "'\(symbol)'"
        }
        
        let symbolsString = symbols.joinWithSeparator(",")
        let query = "\(YQL_QUERY_PREFIX)\(YQL_SYMBOL_QUERY) (\(symbolsString)) \(YQL_QUERY_SUFFIX)"
        return percentEscapedQuery(query: query)
    }
    
    // Returns a query string that is percent escaped encoded
    // @param query: Any query that needs to be percent escaped encoded
    private class func percentEscapedQuery(query query:String) -> String {
        return query.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding)!
    }
    
}
