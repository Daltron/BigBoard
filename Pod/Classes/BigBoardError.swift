
import UIKit

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
