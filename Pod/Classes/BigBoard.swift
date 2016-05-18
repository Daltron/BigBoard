
import UIKit
import Alamofire

class BigBoard: NSObject {
    
    class func stockWithSymbol(symbol symbol:String, success:((BigBoardStock) -> Void), failure:((BigBoardError) -> Void)) -> Request? {
        return BigBoardRequestManager.mapBigBoardStock(symbol: symbol, success: success, failure: failure)
    }
    
    class func stocksWithSymbols(symbols symbols:[String], success:(([BigBoardStock]) -> Void), failure:((BigBoardError) -> Void)) -> Request? {
        return BigBoardRequestManager.mapBigBoardStocks(symbols: symbols, success: success, failure: failure)
    }
}
