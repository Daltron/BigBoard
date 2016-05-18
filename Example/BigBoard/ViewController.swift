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
    
        let dr = BigBoardHistoricalDateRange.thirtyDayRange()
        print(dr.startDate)
        print(dr.endDate)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

