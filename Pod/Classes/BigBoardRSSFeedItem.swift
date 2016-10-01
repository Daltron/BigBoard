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

open class BigBoardRSSFeedItem: Mappable {
    
    fileprivate static var dateFormatter:DateFormatter?
    fileprivate static func sharedDateFormatter() -> DateFormatter {
        if dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter?.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        }
        
        return dateFormatter!
    }

    open var title:String?
    open var link:String?
    open var guid:String?
    open var publicationDate:Date?
    open var author:String?
    open var thumbnailLink:String?
    open var description:String?
    open var content:String?
    
    required public init?(map: Map) {
        mapping(map: map)
    }
    
    open func mapping(map: Map) {
        title <- map["title"]
        link <- map["link"]
        guid <- map["guid"]
        author <- map["author"]
        thumbnailLink <- map["thumbnail"]
        description <- map["description"]
        content <- map["content"]
        
        var publicationDateString = ""
        publicationDateString <- map["pubDate"]
        
        publicationDate = BigBoardRSSFeedItem.sharedDateFormatter().date(from: publicationDateString)
    }
}
