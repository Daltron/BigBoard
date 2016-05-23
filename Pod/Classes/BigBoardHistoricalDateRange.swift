/*
 
 The MIT License (MIT)
 Copyright (c) 2016 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/

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
    
    /*
        Determines if the stock market is closed based on the startDate and endDate. This calclulation does not yet consider holidays
        in which the NYSE is closed.
    */
    
    func stockMarketIsClosedDuringRange() -> Bool {
        let hasSameDatesAndDatesAreOnAWeekend = startDate.isSameDayAsDate(endDate) && (startDate.weekday == 1 || startDate.weekday == 7)
        let datesAreOneDayApartAndBothAreOnAWeekend = endDate.day == startDate.day + 1 && (startDate.weekday == 7 && endDate.weekday == 1)
        return hasSameDatesAndDatesAreOnAWeekend || datesAreOneDayApartAndBothAreOnAWeekend
    }
    
    class func fiveDayRange() -> BigBoardHistoricalDateRange {
        return fiveDayRangeFromDate(endDate: NSDate() - 1.day)
    }
    
    class func fiveDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 5)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }
    
    class func tenDayRange() -> BigBoardHistoricalDateRange {
        return tenDayRangeFromDate(endDate: NSDate() - 1.day)
    }
    
    class func tenDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 10)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }
    
    class func thirtyDayRange() -> BigBoardHistoricalDateRange {
        return thirtyDayRangeFromDate(endDate: NSDate() - 1.day)
    }
    
    class func thirtyDayRangeFromDate(endDate endDate:NSDate) -> BigBoardHistoricalDateRange {
        let (startDate, endDate) = startAndEndDatesForEndDate(endDate: endDate, rangeLength: 30)
        return BigBoardHistoricalDateRange(startDate: startDate, endDate: endDate)
    }
    
    /*  
        Calculates and passes back a valid startDate and endDate for the given rangeLength. If the endDate is on a weekend, then 
        the endDate will be pushed back to the nearest Friday.
        @param endDate: The date the range ends on
        @param rangeLength: The amount of days your range should be
     */

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
