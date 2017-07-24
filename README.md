![BigBoard](https://raw.githubusercontent.com/Daltron/BigBoard/master/Assets/bigboard.png?token=AJPY9yZ_ZB8ao_xZziL0Wcl_-aqFB-PZks5XSN7HwA%3D%3D)

[![CI Status](http://img.shields.io/travis/Daltron/BigBoard.svg?style=flat)](https://travis-ci.org/Dalton/BigBoard)
[![Version](https://img.shields.io/cocoapods/v/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-3.0-4BC51D.svg?style=flat" alt="Language: Swift" /></a>
[![License](https://img.shields.io/cocoapods/l/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![Platform](https://img.shields.io/cocoapods/p/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)

# Notice

As of May 20th, 2017, it appears that Yahoo is dropping support for a few features that BigBoard supports or there is an outage on their end causing a few features to receive a `502 Timeout` response code each time a request is made. I'll be checking frequently to see if something changes. Until then, unforunately, there isn't anything I can do to fix these problems.

## Updated for Swift 3
BigBoard is an elegant financial markets library for iOS written in Swift. Under the hood, BigBoard makes requests to Yahoo Finance API's. Those requests are then processed and clean, friendly, and easy to use objects are returned. The goal of BigBoard is to take the learning curve out of the Yahoo Finance API's and centralize all finanical market data into one core library.

## Features
- [x] Retreive a stock based on a stock symbol
- [x] Retrieve multiple stocks at the same time based on multiple stock symbols
- [x] Retrieve an RSS Feed with the 25 most recent items for a stock symbol
- [x] Retrieve an RSS Feed with the 25 most recent items for multiple stock symbols
- [x] Retrieve historical data for a stock for any custom date range
- [x] Retrieve chart data information for a stock that can easily be used in many charting libraries
- [x] Retrieve graph images with custom trendlines
- [x] Retrieve a list of stocks based on a search term
- [x] Comprehensive unit test coverage
- [x] Extensive documentation

## Library Dependencies

 - [Alamofire](https://github.com/Alamofire/Alamofire): Elegant HTTP Networking in Swift
 - [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper): An Alamofire extension which converts JSON into Swift objects 
 
## Requirements

 - iOS 9.0+, macOS 10.11+
 - xCode 8

## Installation

### CocoaPods

To integrate BigBoard into your xCode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0' # This can be greater than 9.0
use_frameworks!

pod 'BigBoard'
```

Then, run the following command:

```bash
$ pod install
```

This will download any library dependencies you do not already have in your project.

## Usage

### Mapping a Single Stock

```swift
import BigBoard

BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
    // Do something with the stock
}) { (error) in
    print(error)    
}
```

### Mapping Multiple Stocks with One Request

```swift
import BigBoard

BigBoard.stocksWithSymbols(symbols: ["GOOG", "AAPL", "TSLA"], success: { (stocks) in
    // Do something with the stocks
}) { (error) in
    print(error)
}
```

Stocks have the following properties:

```swift
class BigBoardStock: Mappable {
    open var afterHoursChangeRealtime:String?
    open var annualizedGain:String?
    open var ask:String?
    open var askRealTime:String?
    open var averageDailyVolume:String?
    open var bid:String?
    open var bidRealTime:String?
    open var bookValue:String?
    open var change:String?
    open var changeFromFiftyDayMovingAverage:String?
    open var changeFromTwoHundredDayMovingAverage:String?
    open var changeFromYearHigh:String?
    open var changeFromYearLow:String?
    open var changePercentRealtime:String?
    open var changeRealTime:String?
    open var changePercentChange:String?
    open var changeInPercent:String?
    open var commission:String?
    open var currency:String?
    open var daysHigh:String?
    open var daysLow:String?
    open var daysRange:String?
    open var daysRangeRealTime:String?
    open var daysValueChange:String?
    open var daysValueChangeRealTime:String?
    open var dividendPayDate:String?
    open var dividendShare:String?
    open var dividendYield:String?
    open var ebitda:String?
    open var epsEstimateCurrentYear:String?
    open var epsEstimateNextQuarter:String?
    open var epsEstimateNextYear:String?
    open var earningsShare:String?
    open var errorIndicationReturnedForSymbolChangedInvalid:String?
    open var exDividendDate:String?
    open var fiveDayChartModule:BigBoardChartDataModule?
    open var fiveYearChartModule:BigBoardChartDataModule?
    open var fiftyDayMovingAverage:String?
    open var highLimit:String?
    open var historicalData:[BigBoardHistoricalData]?
    open var holdingsGain:String?
    open var holdingsGainPercent:String?
    open var holdingsGainPercentRealtime:String?
    open var holdingsGainRealtime:String?
    open var holdingsValue:String?
    open var holdingsValueRealtime:String?
    open var lastTradeDate:String?
    open var lastTradePriceOnly:String?
    open var lastTradeRealTimeWithTime:String?
    open var lastTradeTime:String?
    open var lastTradeWithTime:String?
    open var lifetimeChartModule:BigBoardChartDataModule?
    open var lowLimit:String?
    open var marketCapRealtime:String?
    open var marketCapitalization:String?
    open var moreInfo:String?
    open var name:String?
    open var notes:String?
    open var oneDayChartModule:BigBoardChartDataModule?
    open var oneMonthChartModule:BigBoardChartDataModule?
    open var oneYearChartModule:BigBoardChartDataModule?
    open var oneYearTargetPrice:String?
    open var open:String?
    open var orderBookRealtime:String?
    open var pegRatio:String?
    open var peRatio:String?
    open var peRatioRealtime:String?
    open var percentChangeFromYearHigh:String?
    open var percentChange:String?
    open var percentChangeFromFiftyDayMovingAverage:String?
    open var percentChangeFromTwoHundredDayMovingAverage:String?
    open var percentChangeFromYearLow:String?
    open var previousClose:String?
    open var priceBook:String?
    open var priceEPSEstimateCurrentYear:String?
    open var priceEPSEstimateNextYear:String?
    open var pricePaid:String?
    open var priceSales:String?
    open var sharesOwned:String?
    open var shortRatio:String?
    open var stockExchange:String?
    open var symbol:String?
    open var threeMonthChartModule:BigBoardChartDataModule?
    open var tickerTrend:String?
    open var tradeDate:String?
    open var twoHundredDayMovingAverage:String?
    open var volume:String?
    open var yearHigh:String?
    open var yearLow:String?
    open var yearRange:String?
}
```

### Retrieving a RSS Feed for a Stock

```swift
import BigBoard

_ = BigBoard.rssFeedForStockWithSymbol(symbol: "GOOG", success: { (feed) in
    // Do something with the RSS feed
}, failure: { (error) in
    print(error)
})

```

This will return the 25 most recent news items for the provided stock symbol 

### Retrieving a RSS Feed for Multiple Stock Symbols

```swift
import BigBoard

_ = BigBoard.rssFeedForStocksWithSymbols(symbols: ["GOOG", "AAPL"], success: { (feed) in
    // Do something with the feed
}, failure: { (error) in
    print(error)
})
```

This will return the 25 most recent news items altogether for the provided stock symbols. If you want the 25 most recent items for each stock symbol, you will need to use the singular function above for each stock symnol.

RSS feeds have the following properties:

```swift
open class BigBoardRSSFeed: Mappable {
    open var title:String?
    open var link:String?
    open var author:String?
    open var description:String?
    open var imageLink:String?
    open var items:[BigBoardRSSFeedItem]?
}
```

RSS feed items have the following properties:

```swift
open class BigBoardRSSFeedItem: Mappable {
    open var title:String?
    open var link:String?
    open var guid:String?
    open var publicationDate:Date?
    open var author:String?
    open var thumbnailLink:String?
    open var description:String?
    open var content:String?
}
```

### Retrieving Historical Data for a Stock

```swift
import BigBoard

let range = BigBoardHistoricalDateRange(startDate: Date() - 3.days, endDate: Date())
_ = stock.mapHistoricalDataWithRange(dateRange: range, success: {
    // The historicalData property is now mapped to the stock with data from the given dataRange
}, failure: { (error) in
    print(error)
})
```

There are currently four different ways to retrieve historical data:

```swift
class BigBoardStock : Mappable {
     open func mapHistoricalDataWithRange(dateRange:BigBoardHistoricalDateRange, success: (() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest?
     open func mapHistoricalDataWithFiveDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? 
     open func mapHistoricalDataWithTenDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? 
     open func mapHistoricalDataWithThirtyDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? 
}
```

### Retrieving Chart Data for a Stock

There are currently seven different ways to retrieve chart data:

```swift
class BigBoardStock : Mappable {
    open func mapOneDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapFiveDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapOneMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapThreeMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapOneYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapFiveYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    open func mapLifetimeChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
}
```
Example:

```swift
import BigBoard

stock.mapOneMonthChartDataModule({
    // oneMonthChartModule is now mapped to the stock
}, failure: { (error) in
    print(error)
})

```

Chart Modules have the following properties:

```swift
class BigBoardChartDataModule: Mappable {
    public var dates:[NSDate]!
    public var dataPoints:[BigBoardChartDataModulePoint]!
}

class BigBoardChartDataModulePoint: Mappable {
    open var date:NSDate!
    open var close:Double!
    open var high:Double!
    open var low:Double!
    open var open:Double!
    open var volume:Int!
}
```

## Retrieve Graph Images with Custom Trendlines

An image of a graph for any stock can easily be set to any UIImageView by calling this function:
```swift
import BigBoard

public extension UIImageView {
    imageView.setGraphAsImageForStock(stock: stock) { (error) in
            print(error)
    }
}
```
The resulting image would be this:

![Graph Image Example](http://chart.finance.yahoo.com/z?s=GOOG&t=3m&q=l&l=on&z=s&p=)

You can also specify custom trendlines and how many months you want your graph image to display:

```swift
import BigBoard

imageView.setGraphAsImageForStock(stock: stock, timelineInMonths: 3, movingAverageTrendlineDays: [14, 50, 100], failure: { (error) in
    print(error)
})
```
The resulting image would be this:

![Graph Image Example](http://chart.finance.yahoo.com/z?s=GOOG&t=3m&q=l&l=on&z=s&p=m14,m50,m100)

### Retrieve a List of Stocks Based on a Search Term

```swift
import BigBoard

BigBoard.stocksContainingSearchTerm(searchTerm: "Google", success: { (searchResultStocks) in
    // Do Something with the searchResultStocks
}) { (error) in
    print(error)
}

```

Search result stocks have the following properties:

```swift
class BigBoardSearchResultStock: Mappable {
    open var symbol:String?
    open var name:String?
    open var exch:String?
    open var type:String?
    open var exchDisp:String?
    open var typeDisp:String?
}

```

### Handling Errors

BigBoardError objects have a type and error message to help determine what kind of error occurred.

```swift
open class BigBoardError: NSObject {
    private(set) open var type:BigBoardErrorType!
    private(set) open var errorMessage:String!
}
```

### Usage Information and Limits


Since BigBoard is built on top of the Yahoo Finance API's, please take a look at this if you plan on using BigBoard for commercial use:
https://developer.yahoo.com/yql/guide/usage_info_limits.html

## Author

Dalton Hinterscher, daltonhint4@gmail.com

## License

BigBoard is available under the MIT license. See the LICENSE file for more info.
