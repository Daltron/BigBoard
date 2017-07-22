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

// UIKit is only available in iOS, not on OSX.
// Do not import this file if platform is OSX

#if os(iOS)
import UIKit
import Alamofire
import AlamofireImage

public extension UIImageView {
    
    /*
        Asynchronously loads and sets the image property with a graph image for a given stock
        @param stock: Stock you want to load the graph for
        @param timelineInMonths: How far in months you want the data of the graph image to display (Default value is 3 months)
        @param movingAverageTrendlineDays: Trendlines in days you want for the data of the graph image. For example, if you specify [5,50],
                                           then the image that is loaded will have both a 5 day moving average trendline and a 50 day moving
                                           average trendline.
 
    */

    public func setGraphAsImageForStock(stock:BigBoardStock, timelineInMonths:Int = 3, movingAverageTrendlineDays:[Int]? = nil, failure:((BigBoardError) -> Void)?) {
        
        let urlString = BigBoardUrlCreator.urlForGraphImage(stock: stock, timelineInMonths: timelineInMonths, movingAverageTrendlineDays: movingAverageTrendlineDays)
        
        Alamofire.request(urlString).validate().responseImage { (response:DataResponse<Image>) in

            switch response.result {
                case .success:
                    if let image = response.result.value {
                        self.contentMode = .scaleAspectFit
                        self.image = image
                    }
                case .failure(let error):
                    if let failure = failure {
                        failure(BigBoardError(nsError: error as NSError))
                    }
            }
        }
    }
}
#endif
