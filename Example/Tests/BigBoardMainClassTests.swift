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
        sampleStock.name = "GOOGLE"
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
        
        sampleStock.mapHistoricalDataWithRange(dateRange: BigBoardTestsHelper.sampleDateRange(), success: {
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
        
        let dateRange = BigBoardHistoricalDateRange(startDate: NSDate(), endDate: NSDate())
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
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
        
        let dateRange = BigBoardHistoricalDateRange(startDate: 1.days.ago, endDate: 2.days.ago)
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
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
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
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
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
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
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
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
    
    func testThatHistoricalDataRequestFailsIfTheStockProvidedIsNotReal() {
        
        let dateRange = BigBoardTestsHelper.sampleDateRange()
        sampleStock.name = nil
        
        sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.description == BigBoardErrorMessage.StockDoesNotExist.rawValue {
                    XCTAssert(true)
                } else {
                    print(error.description)
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatOneDayChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapOneDayChartDataModule({ 
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneDayChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatFiveDayChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapFiveDayChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.fiveDayChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatOneMonthChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapOneMonthChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneMonthChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    
    func testThatThreeMonthChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapThreeMonthChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.threeMonthChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    func testThatOneYearChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapOneYearChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneYearChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatFiveYearChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapFiveYearChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.fiveYearChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    func testThatLifetimeChartDataModuleRequestIsCorrectlyMapped() {
        
        sampleStock.mapLifetimeChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.lifetimeChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
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
