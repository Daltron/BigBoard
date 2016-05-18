//
//  BigBoardHistoricalDateRange.swift
//  Pods
//
//  Created by Dalton Hinterscher on 5/17/16.
//
//

import UIKit
import Timepiece

class BigBoardHistoricalDateRange: NSObject {
    
    var startDate:NSDate!
    var endDate:NSDate!
    
    init(startDate:NSDate, endDate:NSDate) {
        super.init()
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func isFutureDateRange() -> Bool {
        return startDate >= NSDate.today() || endDate >= NSDate.today()
    }
    
    func startDateIsGreaterThanEndDate() -> Bool {
        return startDate > endDate
    }
    
    func stockMarketIsClosedDuringRange() -> Bool {
        
        let hasSameDatesAndDatesAreOnAWeekend = startDate.isSameDayAsDate(endDate) && (startDate.weekday == 1 || startDate.weekday == 7)
        let datesAreOneDayApartAndBothAreOnAWeekend = endDate.day == startDate.day + 1 && (startDate.weekday == 7 && endDate.weekday == 1)
        return hasSameDatesAndDatesAreOnAWeekend || datesAreOneDayApartAndBothAreOnAWeekend
    }
    
    class func fiveDayRange() -> BigBoardHistoricalDateRange {
        return fiveDayRangeFromDate(endDate: NSDate() - 1.days)
    }
    
    class func fiveDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 5)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }
    
    class func tenDayRange() -> BigBoardHistoricalDateRange {
        return fiveDayRangeFromDate(endDate: NSDate() - 10.days)
    }
    
    class func tenDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 10)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }
    
    class func thirtyDayRange() -> BigBoardHistoricalDateRange {
        return thirtyDayRangeFromDate(endDate: NSDate() - 30.days)
    }
    
    class func thirtyDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 30)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }

    private class func startAndEndDatesForEndDate(endDate endDate:NSDate, rangeLength:Int) -> (NSDate, NSDate) {
        
        var finalEndDate = endDate
        var startDate = endDate
        
        while finalEndDate.isOnAWeekend() {
            finalEndDate = finalEndDate - 1.day
        }
        
        var daysWentBack = 0
        while daysWentBack < rangeLength - 1 {
            if startDate.isOnAWeekend() == false {
                daysWentBack += 1
            }
            
            startDate = startDate - 1.day
        }
        
        while startDate.isOnAWeekend() {
            startDate = startDate - 1.day
        }

        return (startDate, finalEndDate)
    }
}
