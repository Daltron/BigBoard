//
//  BigBoardSearchResultStock.swift
//  Pods
//
//  Created by Dalton Hinterscher on 5/20/16.
//
//

import UIKit
import ObjectMapper

class BigBoardSearchResultStock: Mappable {

    var symbol:String?
    var name:String?
    var exch:String?
    var type:String?
    var exchDisp:String?
    var typeDisp:String?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        symbol <- map["symbol"]
        name <- map["name"]
        exch <- map["exch"]
        type <- map["type"]
        exchDisp <- map["exchDisp"]
        typeDisp <- map["typeDisp"]
    }
}
