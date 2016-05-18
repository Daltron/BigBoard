//
//  BigBoardRequestManagerTests.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import BigBoard
import ObjectMapper
import Timepiece

class BigBoardMainClassTests: XCTestCase {
    
    var validationExpectation:XCTestExpectation!
    var sampleStock:BigBoardStock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validationExpectation = expectationWithDescription("Validation")
        sampleStock = BigBoardStock(Map(mappingType: .ToJSON, JSONDictionary: [:]))
        sampleStock.symbol = "GOOG"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatSingleStockIsCorrectlyMappedWhenCallingStockWithSymbolFunction(){
        
        BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
    }
    
    func testThatSingleStockIsCorrectlyMappedWhenCallingStocksWithSymbolsFunction(){
        
        BigBoard.stocksWithSymbols(symbols: ["AAPL"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
    }
    
    func testThatMultipleStocksAreCorrectlyMappedWhenCallingStocksWithSymbolsFunction(){
        
        BigBoard.stocksWithSymbols(symbols: ["AAPL", "GOOG", "TSLA"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
    }
    
    func testThatCallingStockWithSymbolFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvided(){
        BigBoard.stockWithSymbol(symbol: "FAKESTOCK", success: { (stock) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }
        
        waitForRequestToFinish()

    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvidedForASingleSymbol() {
        BigBoard.stocksWithSymbols(symbols: ["FAKESTOCK"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }
        
        waitForRequestToFinish()

    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvidedForMultipleSymbols() {
        BigBoard.stocksWithSymbols(symbols: ["AAPL", "FAKESTOCK", "GOOG"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenMultipleInvalidStockSymbolAreProvidedForMultipleSymbols() {
        BigBoard.stocksWithSymbols(symbols: ["AAPL", "FAKESTOCK", "GOOG", "FAKESTOCK2"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatHistoricalDataIsReturnedWhenTheGoogleStockSymbolIsUsed(){
        
        sampleStock.mapHistoricalData(startDate: BigBoardTestsHelper.sampleStartDate(), endDate: BigBoardTestsHelper.sampleEndDate(), success: {
            if self.sampleStock.historicalData?.isEmpty == false {
                self.validationExpectation.fulfill()
                XCTAssert(true)
            } else {
                self.validationExpectation.fulfill()
                XCTFail("historicalData array is empty")
            }
        }, failure: { (error) in
                self.validationExpectation.fulfill()
                XCTFail(error.description)
        })
        
        waitForRequestToFinish()
        
    }
    
    func testThatHistoricalDataRequestFailsWhenStartDateIsEqualToToday() {
        
        sampleStock.mapHistoricalData(startDate: NSDate(), endDate: NSDate(), success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
        }, failure: { (error) in
            self.validationExpectation.fulfill()
            if error.description == BigBoardErrorMessage.MappingFutureDate.rawValue {
                XCTAssert(true)
            } else {
                XCTFail("The wrong error message was passed back.")
            }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStartDateIsGreaterThanEndDate() {
        
        sampleStock.mapHistoricalData(startDate: 1.days.ago, endDate: 2.days.ago, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
        }, failure: { (error) in
            self.validationExpectation.fulfill()
            if error.description == BigBoardErrorMessage.StartDateGreaterThanEndDate.rawValue {
                XCTAssert(true)
            } else {
                XCTFail("The wrong error message was passed back.")
            }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateAndEndDateAreTheSameAndTheDayIsSaturday() {
        let startDate = NSDate().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        let endDate = NSDate().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        
        sampleStock.mapHistoricalData(startDate: startDate, endDate: endDate, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.description == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(true)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateAndEndDateAreTheSameAndTheDayIsSunday() {
        let startDate = NSDate().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        let endDate = NSDate().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        
        sampleStock.mapHistoricalData(startDate: startDate, endDate: endDate, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.description == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(true)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateIsASaturdayAndTheEndDateIsTheFirstSundayAfter() {
        let startDate = NSDate().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        let endDate = NSDate().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        
        sampleStock.mapHistoricalData(startDate: startDate, endDate: endDate, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.description == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(true)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }


    // MARK: Helpers
    
    func waitForRequestToFinish(){
        waitForExpectationsWithTimeout(60.0) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
}
