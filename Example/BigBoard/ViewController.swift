//
//  ViewController.swift
//  BigBoard
//
//  Created by Dalton on 04/14/2016.
//  Copyright (c) 2016 Dalton. All rights reserved.
//

import UIKit
import Timepiece

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BigBoard.stocksWithSymbols(symbols: ["GOOG"], success: { (stocks) in
            print(stocks.first?.symbol!)
            stocks.first!.mapHistoricalData(startDate: NSDate() - 2.days, endDate: NSDate() - 3.days, success: {
                print(stocks.first?.historicalData)
            }, failure: { (error) in
                print(error.description)
            })
        }) { (error) in
            print(error)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

