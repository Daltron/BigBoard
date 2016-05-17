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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        validationExpectation = expectationWithDescription("Validation")
        
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
        
        BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
            stock.mapHistoricalData(startDate: BigBoardTestsHelper.sampleStartDate(), endDate: BigBoardTestsHelper.sampleEndDate(), success: {
                if stock.historicalData?.isEmpty == false {
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
