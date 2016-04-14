//
//  BigBoardQueryCreatorTests.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import BigBoard

class BigBoardQueryCreatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatQueryStringIsCorrectlyCreatedForOneStockSymbol(){
        let bigBoardQuery = BigBoardQueryCreator.queryForStockSymbol(symbol: "GOOG")
        let yqlQuery = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('GOOG')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        XCTAssertEqual(bigBoardQuery, yqlQuery)
    }
    
    func testThatQueryStringIsCorrectlyCreatedForMultipleStockSymbols(){
        let bigBoardQuery = BigBoardQueryCreator.queryForStockSymbols(symbols: ["GOOG", "AAPL", "TSLA"])
        let yqlQuery = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('GOOG','AAPL','TSLA')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        XCTAssertEqual(bigBoardQuery, yqlQuery)
    }
}
