//
//  ExampleHistoricalDataModel.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleHistoricalDataModel: NSObject {

    var stock:BigBoardStock!
    
    init(stock:BigBoardStock) {
        super.init()
        self.stock = stock
    }
}
