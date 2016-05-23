//
//  ViewController.swift
//  BigBoard
//
//  Created by Dalton on 04/14/2016.
//  Copyright (c) 2016 Dalton. All rights reserved.
//

import UIKit
import Timepiece

class ExampleViewController: UIViewController, ExampleViewDelegate {
    
    var model:ExampleModel!
    var exampleView:ExampleView!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = .None
        model = ExampleModel()
        exampleView = ExampleView(delegate: self)
        view = exampleView
        title = "BigBoard"
        
        BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
            
        }) { (error) in
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addStockButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    func addStockButtonPressed() {
        let addStockController = ExampleAddStockViewController { (stock:BigBoardSearchResultStock) in
            print("Loading stock with symbol: \(stock.symbol!)")
            self.model.mapStockWithSymbol(symbol: stock.symbol!, success: {
                print("Stock successfully mapped.")
                print("--------------------------")
                self.exampleView.stocksTableView.reloadData()
            }, failure: { (error) in
                print(error)
                print("--------------------------")
            })
        }
        navigationController?.pushViewController(addStockController, animated: true)
    }
    
    // MARK: ExampleViewDelegate Implementation
    
    func numberOfStocks() -> Int {
        return model.numberOfStocks()
    }
    
    func stockAtIndex(index: Int) -> BigBoardStock {
        return model.stockAtIndex(index)
    }
    
    func stockSelectedAtIndex(index:Int) {
        let exampleStockDetailsModel = ExampleStockDetailsModel(stock: model.stockAtIndex(index))
        let exampleStockDetailsViewController = ExampleStockDetailsViewController(model: exampleStockDetailsModel)
        navigationController!.pushViewController(exampleStockDetailsViewController, animated: true)
    }
    
    func refreshControllPulled() {
        model.refreshStocks(success: { 
            self.exampleView.refreshControl.endRefreshing()
            self.exampleView.stocksTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

}

