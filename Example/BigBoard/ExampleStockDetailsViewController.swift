//
//  ExampleStockDetailsViewController.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleStockDetailsViewController: UIViewController, ExampleStockDetailsViewDelegate {

    var model:ExampleStockDetailsModel!
    var exampleView:ExampleStockDetailsView!
    
    init(model:ExampleStockDetailsModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        exampleView = ExampleStockDetailsView(delegate: self)
        view = exampleView
        title = model.stock.name!
        edgesForExtendedLayout = UIRectEdge()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        exampleView.graphImageView.setGraphAsImageForStock(stock: model.stock, timelineInMonths: 3, movingAverageTrendlineDays: [5, 10, 50]) { (error) in
            print(error)
        }
        
        model.loadRSSFeed(success: {
            print("RSS Feed sucessfully mapped")
            print("--------------------------")
            self.exampleView.rssFeedTableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
    
    // MARK: ExampleStockDetailsViewDelegate Implementation
    
    func numberOfRSSFeedItems() -> Int {
        return model.numberOfRSSFeedItems()
    }
    
    func rssFeedItemAtIndex(_ index:Int) -> BigBoardRSSFeedItem {
        return model.rssFeedItemAtIndex(index)
    }
    
    func rssFeedItemSelectedAtIndex(_ index: Int) {
        let feedItemUrl = URL(string: model.rssFeedItemAtIndex(index).link!)
        UIApplication.shared.openURL(feedItemUrl!)
    }
    
}
