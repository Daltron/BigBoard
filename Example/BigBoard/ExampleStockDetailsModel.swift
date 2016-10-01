//
//  ExampleStockDetailsModel.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleStockDetailsModel: NSObject {

    var stock:BigBoardStock!
    var rssFeed:BigBoardRSSFeed!
    
    init(stock:BigBoardStock) {
        super.init()
        self.stock = stock
    }
    
    func numberOfRSSFeedItems() -> Int {
        if let rssFeed = rssFeed {
            return rssFeed.items!.count
        } else {
            return 0
        }
    }
    
    func rssFeedItemAtIndex(_ index:Int) -> BigBoardRSSFeedItem {
        return rssFeed.items![index]
    }
    
    func loadRSSFeed(success:@escaping (() -> Void), failure:@escaping ((BigBoardError) -> Void)) {
        _ = BigBoard.rssFeedForStockWithSymbol(symbol: stock.symbol!, success: { (feed) in
            self.rssFeed = feed
            success()
        }) { (error) in
            failure(error)
        }

    }
}
