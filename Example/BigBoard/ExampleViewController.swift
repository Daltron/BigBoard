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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Mapping Sample Stocks...")
        model.mapSampleStocks(success: {
            print("Sample Stocks successfully mapped...")
            print("--------------------------")
            self.exampleView.stocksTableView.reloadData()
        }) { (error) in
            print(error)
            print("--------------------------")
        }
    }
    
    
    // MARK: ExampleViewDelegate Implementation
    
    func numberOfStocks() -> Int {
        return model.numberOfStocks()
    }
    
    func stockAtIndex(index: Int) -> BigBoardStock {
        return model.stockAtIndex(index)
    }
    
    func addStockButtonPressed(symbol symbol: String) {
        print("Mapping Stock with Symbol: \(symbol)")
        model.mapStockWithSymbol(symbol: symbol, success: {
            print("Stock Successfully Mapped")
            print("--------------------------")
            self.exampleView.stocksTableView.reloadData()
        }) { (error) in
            print(error)
            print("--------------------------")
        }
    }
    
    func stockAtIndexPressed(index:Int) {
        let exampleHistoricalDataModel = ExampleHistoricalDataModel(stock: model.stockAtIndex(index))
        let exampleHistoricalDataViewController = ExampleHistoricalDataViewController(model: exampleHistoricalDataModel)
        navigationController!.pushViewController(exampleHistoricalDataViewController, animated: true)
    }

}

