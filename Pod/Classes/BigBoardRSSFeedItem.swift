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

public class BigBoardRSSFeedItem: Mappable {
    
    private static var dateFormatter:NSDateFormatter?
    private static func sharedDateFormatter() -> NSDateFormatter {
        if dateFormatter == nil {
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        }
        
        return dateFormatter!
    }

    var title:String?
    var link:String?
    var guid:String?
    var publicationDate:NSDate?
    var author:String?
    var thumbnailLink:String?
    var description:String?
    var content:String?
    
    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
        title <- map["title"]
        link <- map["link"]
        guid <- map["guid"]
        author <- map["author"]
        thumbnailLink <- map["thumbnail"]
        description <- map["description"]
        content <- map["content"]
        
        var publicationDateString = ""
        publicationDateString <- map["pubDate"]
        
        publicationDate = BigBoardRSSFeedItem.sharedDateFormatter().dateFromString(publicationDateString)
    }
}
