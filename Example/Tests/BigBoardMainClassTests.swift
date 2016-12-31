//
//  BigBoardRequestManagerTests.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import BigBoard

class BigBoardMainClassTests: XCTestCase {
    
    var validationExpectation:XCTestExpectation!
    var sampleStock:BigBoardStock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validationExpectation = expectation(description: "Validation")
        sampleStock = BigBoardTestsHelper.sampleStock()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatSingleStockIsCorrectlyMappedWhenCallingStockWithSymbolFunction(){
        
        _ = BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
    
        waitForRequestToFinish()
    }
    
    func testThatSingleStockIsCorrectlyMappedWhenCallingStocksWithSymbolsFunction(){
        
        _ = BigBoard.stocksWithSymbols(symbols: ["AAPL"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        self.waitForRequestToFinish()
    }
    
    func testThatMultipleStocksAreCorrectlyMappedWhenCallingStocksWithSymbolsFunction(){
        
        _ = BigBoard.stocksWithSymbols(symbols: ["AAPL", "GOOG", "TSLA"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTAssert(true)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
    }
    
    func testThatCallingStockWithSymbolFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvided(){
        _ = BigBoard.stockWithSymbol(symbol: "FAKESTOCK", success: { (stock) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(error.type == BigBoardErrorType.InvalidStockSymbol)
        }
        
        waitForRequestToFinish()

    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvidedForASingleSymbol() {
        _ = BigBoard.stocksWithSymbols(symbols: ["FAKESTOCK"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(error.type == BigBoardErrorType.InvalidStockSymbol)
        }
        
        waitForRequestToFinish()

    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenAnInvalidStockSymbolIsProvidedForMultipleSymbols() {
        _ = BigBoard.stocksWithSymbols(symbols: ["AAPL", "FAKESTOCK", "GOOG"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(error.type == BigBoardErrorType.InvalidStockSymbol)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatCallingStocksWithSymbolsFunctionReturnsAnErrorWhenMultipleInvalidStockSymbolAreProvidedForMultipleSymbols() {
        _ = BigBoard.stocksWithSymbols(symbols: ["AAPL", "FAKESTOCK", "GOOG", "FAKESTOCK2"], success: { (stocks) in
            self.validationExpectation.fulfill()
            XCTFail()
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTAssert(error.type == BigBoardErrorType.InvalidStockSymbol)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatHistoricalDataIsReturnedWhenTheGoogleStockSymbolIsUsed(){
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: BigBoardTestsHelper.sampleDateRange(), success: {
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
        
        let dateRange = BigBoardHistoricalDateRange(startDate: Date(), endDate: Date())
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
        }, failure: { (error) in
            self.validationExpectation.fulfill()
            if error.errorMessage == BigBoardErrorMessage.MappingFutureDate.rawValue {
                XCTAssert(error.type == BigBoardErrorType.MappingFutureDate)
            } else {
                XCTFail("The wrong error message was passed back.")
            }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStartDateIsGreaterThanEndDate() {
        
        let dateRange = BigBoardHistoricalDateRange(startDate: 1.days.ago, endDate: 2.days.ago)
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
        }, failure: { (error) in
            self.validationExpectation.fulfill()
            if error.errorMessage == BigBoardErrorMessage.StartDateGreaterThanEndDate.rawValue {
                XCTAssert(error.type == BigBoardErrorType.StartDateGreaterThanEndDate)
            } else {
                XCTFail("The wrong error message was passed back.")
            }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateAndEndDateAreTheSameAndTheDayIsSaturday() {
        
        let startDate:Date = Date().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        let endDate:Date = Date().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.errorMessage == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(error.type == BigBoardErrorType.StockMarketIsClosedInGivenDateRange)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateAndEndDateAreTheSameAndTheDayIsSunday() {
        
        let startDate:Date = Date().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        let endDate:Date = Date().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.errorMessage == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(error.type == BigBoardErrorType.StockMarketIsClosedInGivenDateRange)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsWhenStockMarketIsClosedInTheGivenDateRangeAndStartDateIsASaturdayAndTheEndDateIsTheFirstSundayAfter() {
        
        let startDate:Date = Date().change(year: 2016, month: 1, day: 2, hour: 1, minute: 1, second: 1)
        let endDate:Date = Date().change(year: 2016, month: 1, day: 3, hour: 1, minute: 1, second: 1)
        let dateRange = BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.errorMessage == BigBoardErrorMessage.StockMarketIsClosedInGivenDateRange.rawValue {
                    XCTAssert(error.type == BigBoardErrorType.StockMarketIsClosedInGivenDateRange)
                } else {
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatHistoricalDataRequestFailsIfTheStockProvidedIsNotReal() {
        
        let dateRange = BigBoardTestsHelper.sampleDateRange()
        sampleStock.name = nil
        
        _ = sampleStock.mapHistoricalDataWithRange(dateRange: dateRange, success: {
            self.validationExpectation.fulfill()
            XCTFail("This test should have failed.")
            }, failure: { (error) in
                self.validationExpectation.fulfill()
                if error.errorMessage == BigBoardErrorMessage.StockDoesNotExist.rawValue {
                    XCTAssert(error.type == BigBoardErrorType.InvalidStockSymbol)
                } else {
                    print(error.description)
                    XCTFail("The wrong error message was passed back.")
                }
        })
        
        waitForRequestToFinish()
    }
    
    func testThatOneDayChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapOneDayChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneDayChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatFiveDayChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapFiveDayChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.fiveDayChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatOneMonthChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapOneMonthChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneMonthChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    
    func testThatThreeMonthChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapThreeMonthChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.threeMonthChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    func testThatOneYearChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapOneYearChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.oneYearChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }
    
    func testThatFiveYearChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapFiveYearChartDataModule({
            self.validationExpectation.fulfill()
            XCTAssert(self.sampleStock.fiveYearChartModule != nil)
        }) { (error) in
            self.validationExpectation.fulfill()
            XCTFail(error.description)
        }
        
        waitForRequestToFinish()
        
    }

    func testThatLifetimeChartDataModuleRequestIsCorrectlyMapped() {
        
        _ = sampleStock.mapLifetimeChartDataModule({
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
        
        waitForExpectations(timeout: 60.0) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
}
