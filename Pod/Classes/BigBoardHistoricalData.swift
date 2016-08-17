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

import ObjectMapper

public class BigBoardHistoricalData: Mappable {

    public var symbol:String?
    public var date:String?
    public var open:String?
    public var high:String?
    public var low:String?
    public var close:String?
    public var volume:String?
    public var adjClose:String?

    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
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
