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
    
    func stockAtIndex(index:Int) -> BigBoardStock {
        return stocks[index]
    }
    
    func mapSampleStocks(success success:(() -> Void), failure:((BigBoardError) -> Void)) {
        BigBoard.stocksWithSymbols(symbols: ["GOOG", "AAPL", "TSLA"], success: { (stocks) in
            self.stocks = stocks
            success()
        }, failure: failure)
    }
    
    func mapStockWithSymbol(symbol symbol:String, success:(() -> Void), failure:((BigBoardError) -> Void)) {
        BigBoard.stockWithSymbol(symbol: symbol, success: { (stock) in
            self.stocks.append(stock)
            success()
        }, failure: failure)
    }
}
