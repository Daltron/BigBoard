//
//  ExampleAddStockModel.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleAddStockModel: NSObject {
    
    var searchResultStocks:[BigBoardSearchResultStock] = []

    func numberOfSearchResultStocks() -> Int {
        return searchResultStocks.count
    }
    
    func searchResultStockAtIndex(_ index:Int) -> BigBoardSearchResultStock {
        return searchResultStocks[index]
    }
    
    func fetchStocksForSearchTerm(_ searchTerm:String, success:@escaping (() -> Void), failure:@escaping (BigBoardError) -> Void) {
        _ = BigBoard.stocksContainingSearchTerm(searchTerm: searchTerm, success: { (stocks:[BigBoardSearchResultStock]) in
            self.searchResultStocks = stocks
            success()
        }, failure: failure)
    }
    
}
