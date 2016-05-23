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

import Foundation

public enum BigBoardErrorMessage : String {
    case MappingFutureDate = "You are trying to map historical data for a future date."
    case StartDateGreaterThanEndDate = "Your start date is greater than your end date. Your start date must take place or be equal to your end date."
    case StockMarketIsClosedInGivenDateRange = "Your start and end dates are pointing to dates when the stock market is closed. No historical data exists for these dates."
    case StockDoesNotExist = "You are trying to map historical data for a stock that does not exist."
}

class BigBoardError: NSObject {
    
    private let ERROR_PREFIX = "BigBoardError:"

    override var description: String {
        return errorMessage
    }
    
    var errorMessage:String!
    
    init(invalidSymbol:String) {
        super.init()
        errorMessage = "\(ERROR_PREFIX) \(invalidSymbol.uppercaseString) is not a real stock."
    }
    
    init(invalidSymbols:[String]) {
        super.init()
        if invalidSymbols.count > 1 {
            errorMessage = "\(ERROR_PREFIX) \(invalidSymbols.joinWithSeparator(", ")) are not real stocks."
        } else {
            errorMessage = "\(ERROR_PREFIX) \(invalidSymbols.first!.uppercaseString) is not a real stock."
        }
    }
    
    init(nsError:NSError) {
        super.init()
        errorMessage = "\(ERROR_PREFIX) \(nsError.localizedDescription)"
    }
    
    init(errorMessageType:BigBoardErrorMessage) {
        super.init()
        self.errorMessage = errorMessageType.rawValue
    }
}
