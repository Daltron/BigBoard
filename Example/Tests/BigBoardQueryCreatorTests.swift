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
    
    func testThatUrlStringIsCorrectlyCreatedForOneStockSymbol(){
        let bigBoardUrl = BigBoardUrlCreator.urlForStockSymbol(symbol: "GOOG")
        let yqlUrl = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('GOOG')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForMultipleStockSymbols(){
        let bigBoardUrl = BigBoardUrlCreator.urlForStockSymbols(symbols: ["GOOG", "AAPL", "TSLA"])
        let yqlUrl = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('GOOG','AAPL','TSLA')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForHistoricalData() {
        let dateRange = BigBoardHistoricalDateRange(startDate: BigBoardTestsHelper.sampleStartDate(), endDate: BigBoardTestsHelper.sampleEndDate())
        let bigBoardUrl = BigBoardUrlCreator.urlForHistoricalDataWithStockSymbol(symbol: "GOOG", dateRange: dateRange)
        let yqlUrl = "http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.historicaldata%20WHERE%20symbol%20IN%20('GOOG')%20AND%20startDate=%20%222015-06-04%22%20AND%20endDate=%20%222015-06-11%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithOneDayRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .OneDay)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=1d/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithFiveDayRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .FiveDay)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=5d/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithOneMonthRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .OneMonth)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=1m/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithThreeMonthRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .ThreeMonth)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=3m/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithOneYearRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .OneYear)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=1y/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithFiveYearRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .FiveYear)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=5y/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForChartDataModuleWithLifetimeRange() {
        let bigBoardUrl = BigBoardUrlCreator.urlForChartDataModuleWithSymbol(symbol: "GOOG", range: .Lifetime)
        let yqlUrl = "http://chartapi.finance.yahoo.com/instrument/1.0/GOOG/chartdata;type=quote;range=max/json"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForGraphImageWithOneTrendline() {
        let bigBoardUrl = BigBoardUrlCreator.urlForGraphImage(stock:BigBoardTestsHelper.sampleStock(), timelineInMonths: 6, movingAverageTrendlineDays: [5])
        let yqlUrl = "http://chart.finance.yahoo.com/z?s=GOOG&t=6m&q=l&l=on&z=s&p=m5"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
    func testThatUrlStringIsCorrectlyCreatedForGraphImageWithMultipleTrendlines() {
        let bigBoardUrl = BigBoardUrlCreator.urlForGraphImage(stock:BigBoardTestsHelper.sampleStock(), timelineInMonths: 6, movingAverageTrendlineDays: [5, 30, 60, 120])
        let yqlUrl = "http://chart.finance.yahoo.com/z?s=GOOG&t=6m&q=l&l=on&z=s&p=m5,m30,m60,m120"
        XCTAssertEqual(bigBoardUrl, yqlUrl)
    }
    
}
