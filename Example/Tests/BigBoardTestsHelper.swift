//
//  BigBoardTestsHelper.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ObjectMapper

class BigBoardTestsHelper: NSObject {
    
    class func sampleDateRange() -> BigBoardHistoricalDateRange {
        return BigBoardHistoricalDateRange(startDate: sampleStartDate(), endDate: sampleEndDate())
    }

    class func sampleStartDate() -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2015
        dateComponents.month = 6
        dateComponents.day = 4
        
        return calendar.date(from: dateComponents)!
    }
    
    class func sampleEndDate() -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2015
        dateComponents.month = 6
        dateComponents.day = 11
        
        return calendar.date(from: dateComponents)!
    }
    
    class func sampleStock() -> BigBoardStock {
        let sampleStock = BigBoardStock(map: Map(mappingType: .toJSON, JSON: [:]))
        sampleStock!.symbol = "GOOG"
        sampleStock!.name = "GOOGLE"
        return sampleStock!
    }

}
