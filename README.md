![BigBoard](https://raw.githubusercontent.com/Daltron/BigBoard/master/Assets/bigboard.png?token=AJPY9yZ_ZB8ao_xZziL0Wcl_-aqFB-PZks5XSN7HwA%3D%3D)


[![CI Status](http://img.shields.io/travis/Daltron/BigBoard.svg?style=flat)](https://travis-ci.org/Dalton/BigBoard)
[![Version](https://img.shields.io/cocoapods/v/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-3.0-4BC51D.svg?style=flat" alt="Language: Swift" /></a>
[![License](https://img.shields.io/cocoapods/l/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![Platform](https://img.shields.io/cocoapods/p/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)

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

 - iOS 9.0+
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
    public var afterHoursChangeRealtime:String?
    public var annualizedGain:String?
    public var ask:String?
    public var askRealTime:String?
    public var averageDailyVolume:String?
    public var bid:String?
    public var bidRealTime:String?
    public var bookValue:String?
    public var change:String?
    public var changeFromFiftyDayMovingAverage:String?
    public var changeFromTwoHundredDayMovingAverage:String?
    public var changeFromYearHigh:String?
    public var changeFromYearLow:String?
    public var changePercentRealtime:String?
    public var changeRealTime:String?
    public var changePercentChange:String?
    public var changeInPercent:String?
    public var commission:String?
    public var currency:String?
    public var daysHigh:String?
    public var daysLow:String?
    public var daysRange:String?
    public var daysRangeRealTime:String?
    public var daysValueChange:String?
    public var daysValueChangeRealTime:String?
    public var dividendPayDate:String?
    public var dividendShare:String?
    public var dividendYield:String?
    public var ebitda:String?
    public var epsEstimateCurrentYear:String?
    public var epsEstimateNextQuarter:String?
    public var epsEstimateNextYear:String?
    public var earningsShare:String?
    public var errorIndicationReturnedForSymbolChangedInvalid:String?
    public var exDividendDate:String?
    public var fiveDayChartModule:BigBoardChartDataModule?
    public var fiveYearChartModule:BigBoardChartDataModule?
    public var fiftyDayMovingAverage:String?
    public var highLimit:String?
    public var historicalData:[BigBoardHistoricalData]?
    public var holdingsGain:String?
    public var holdingsGainPercent:String?
    public var holdingsGainPercentRealtime:String?
    public var holdingsGainRealtime:String?
    public var holdingsValue:String?
    public var holdingsValueRealtime:String?
    public var lastTradeDate:String?
    public var lastTradePriceOnly:String?
    public var lastTradeRealTimeWithTime:String?
    public var lastTradeTime:String?
    public var lastTradeWithTime:String?
    public var lifetimeChartModule:BigBoardChartDataModule?
    public var lowLimit:String?
    public var marketCapRealtime:String?
    public var marketCapitalization:String?
    public var moreInfo:String?
    public var name:String?
    public var notes:String?
    public var oneDayChartModule:BigBoardChartDataModule?
    public var oneMonthChartModule:BigBoardChartDataModule?
    public var oneYearChartModule:BigBoardChartDataModule?
    public var oneYearTargetPrice:String?
    public var open:String?
    public var orderBookRealtime:String?
    public var pegRatio:String?
    public var peRatio:String?
    public var peRatioRealtime:String?
    public var percentChangeFromYearHigh:String?
    public var percentChange:String?
    public var percentChangeFromFiftyDayMovingAverage:String?
    public var percentChangeFromTwoHundredDayMovingAverage:String?
    public var percentChangeFromYearLow:String?
    public var previousClose:String?
    public var priceBook:String?
    public var priceEPSEstimateCurrentYear:String?
    public var priceEPSEstimateNextYear:String?
    public var pricePaid:String?
    public var priceSales:String?
    public var sharesOwned:String?
    public var shortRatio:String?
    public var stockExchange:String?
    public var symbol:String?
    public var threeMonthChartModule:BigBoardChartDataModule?
    public var tickerTrend:String?
    public var tradeDate:String?
    public var twoHundredDayMovingAverage:String?
    public var volume:String?
    public var yearHigh:String?
    public var yearLow:String?
    public var yearRange:String?
}
```

### Retrieving Chart Data for a Stock

There are currently seven different ways to retrieve chart data:

```swift
class BigBoardStock : Mappable {
    public func mapOneDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapFiveDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapOneMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapThreeMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapOneYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapFiveYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    public func mapLifetimeChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
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
    public var date:NSDate!
    public var close:Double!
    public var high:Double!
    public var low:Double!
    public var open:Double!
    public var volume:Int!
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
    public var symbol:String?
    public var name:String?
    public var exch:String?
    public var type:String?
    public var exchDisp:String?
    public var typeDisp:String?
}

```

### Usage Information and Limits


Since BigBoard is built on top of the Yahoo Finance API's, please take a look at this if you plan on using BigBoard for commercial use:
https://developer.yahoo.com/yql/guide/usage_info_limits.html

## Author

Dalton Hinterscher, daltonhint4@gmail.com

## License

BigBoard is available under the MIT license. See the LICENSE file for more info.
