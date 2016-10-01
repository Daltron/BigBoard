//
//  ExampleAddStockViewController.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleAddStockViewController: UIViewController, ExampleAddStockViewDelegate {
    
    var model:ExampleAddStockModel!
    var exampleView:ExampleAddStockView!
    var selectionCallback:((BigBoardSearchResultStock) -> Void)!

    init(selectionCallback:@escaping ((BigBoardSearchResultStock) -> Void)){
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = UIRectEdge()
        self.selectionCallback = selectionCallback
        model = ExampleAddStockModel()
        exampleView = ExampleAddStockView(delegate: self)
        view = exampleView
        title = "Add Stock"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ExampleAddStockViewDelegate Implementation

    func numberOfSearchResultStocks() -> Int {
        return model.numberOfSearchResultStocks()
    }
    
    func searchResultStockAtIndex(_ index:Int) -> BigBoardSearchResultStock {
        return model.searchResultStockAtIndex(index)
    }
    
    func searchTermChanged(searchTerm:String) {
        model.fetchStocksForSearchTerm(searchTerm, success: { 
            self.exampleView.stocksTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func stockResultSelectedAtIndex(_ index: Int) {
        selectionCallback(searchResultStockAtIndex(index))
        navigationController!.popViewController(animated: true)
    }
}
