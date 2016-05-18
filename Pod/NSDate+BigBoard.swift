//
//  NSDate+BigBoard.swift.swift
//  Pods
//
//  Created by Dalton Hinterscher on 5/17/16.
//
//

import UIKit

extension NSDate {
    
    func isSameDayAsDate(date:NSDate) -> Bool {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        return calendar!.isDate(self, inSameDayAsDate: date)
    }
}
