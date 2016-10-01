//
//  ExampleModel.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleModel: NSObject {

    var stocks:[BigBoardStock] = []
    
    func numberOfStocks() -> Int {
        return stocks.count
    }
    
    func stockAtIndex(_ index:Int) -> BigBoardStock {
        return stocks[index]
    }
    
    func refreshStocks(success:@escaping (() -> Void), failure:@escaping (BigBoardError) -> Void) {
        
        var stockSymbols:[String] = []
        
        for stock in stocks {
            stockSymbols.append(stock.symbol!)
        }
        
        _ = BigBoard.stocksWithSymbols(symbols: stockSymbols, success: { (stocks) in
            self.stocks = stocks
            success()
        }, failure: failure)
    }
    
    func mapSampleStocks(success:@escaping (() -> Void), failure:@escaping ((BigBoardError) -> Void)) {
        _ = BigBoard.stocksWithSymbols(symbols: ["GOOG", "AAPL", "TSLA"], success: { (stocks) in
            self.stocks = stocks
            success()
        }, failure: failure)
    }
    
    func mapStockWithSymbol(symbol:String, success:@escaping (() -> Void), failure:@escaping ((BigBoardError) -> Void)) {
        _ = BigBoard.stockWithSymbol(symbol: symbol, success: { (stock) in
            self.stocks.append(stock)
            success()
        }, failure: failure)
    }
}
