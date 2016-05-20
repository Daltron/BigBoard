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
        mapping(map)
    }
    
    func mapping(map: Map) {
        symbol <- map["Symbol"]
        date <- map["Date"]
        open <- map["Open"]
        high <- map["High"]
        low <- map["Low"]
        close <- map["Close"]
        volume <- map["Volume"]
        adjClose <- map["Adj_Close"]
    }
}
