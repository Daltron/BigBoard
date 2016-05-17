//
//  BigBoardHistoricalData.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ObjectMapper

class BigBoardHistoricalData: Mappable {

    var symbol:String?
    var date:String?
    var open:String?
    var high:String?
    var low:String?
    var close:String?
    var volume:String?
    var adjClose:String?

    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        symbol <- map["Symbol"]
        symbol <- map["Date"]
        symbol <- map["Open"]
        symbol <- map["High"]
        symbol <- map["Low"]
        symbol <- map["Close"]
        symbol <- map["Volume"]
        symbol <- map["Adj_Close"]
    }
}
