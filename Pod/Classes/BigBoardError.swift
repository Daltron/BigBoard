
import UIKit

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
    
    init(customErrorMessage:String) {
        super.init()
        self.errorMessage = customErrorMessage
    }
}
