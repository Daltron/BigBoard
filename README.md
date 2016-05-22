![BigBoard](https://raw.githubusercontent.com/Daltron/BigBoard/master/Assets/bigboard.png?token=AJPY9yZ_ZB8ao_xZziL0Wcl_-aqFB-PZks5XSN7HwA%3D%3D)

[![CI Status](http://img.shields.io/travis/Dalton/BigBoard.svg?style=flat)](https://travis-ci.org/Dalton/BigBoard)
[![Version](https://img.shields.io/cocoapods/v/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![License](https://img.shields.io/cocoapods/l/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![Platform](https://img.shields.io/cocoapods/p/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)

BigBoard is a powerful yet easy to use finance API for iOS and OSX.

## Features
- [x] Retreive a stock based on a stock symbol
- [x] Retrieve multiple stocks at the same time based on multiple stock symbols
- [x] Retrieve historical data for a stock for any custom date range
- [x] Retrieve chart data information for a stock that can easily be used in many charting libraries
- [x] Retrieve graph images with custom trendlines
- [x] Retrieve a list of stocks based on a search term
- [x] Comprehensive unit test coverage
- [x] Extensive documentation

## Library Dependencies

 - [Alamofire](https://github.com/Alamofire/Alamofire): Elegant HTTP Networking in Swift
 - [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper): An Alamofire extension which converts JSON into Swift objects 
 - [Timepiece](https://github.com/naoty/Timepiece): Intuitive NSDate extensions in Swift

## Installation

### CocoaPods

To integrate BigBoard into your xCode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
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
    var afterHoursChangeRealtime:String?
    var annualizedGain:String?
    var ask:String?
    var askRealTime:String?
    var averageDailyVolume:String?
    var bid:String?
    var bidRealTime:String?
    var bookValue:String?
    var change:String?
    var changeFromFiftyDayMovingAverage:String?
    var changeFromTwoHundredDayMovingAverage:String?
    var changeFromYearHigh:String?
    var changeFromYearLow:String?
    var changePercentRealtime:String?
    var changeRealTime:String?
    var changePercentChange:String?
    var changeInPercent:String?
    var commission:String?
    var currency:String?
    var daysHigh:String?
    var daysLow:String?
    var daysRange:String?
    var daysRangeRealTime:String?
    var daysValueChange:String?
    var daysValueChangeRealTime:String?
    var dividendPayDate:String?
    var dividendShare:String?
    var dividendYield:String?
    var ebitda:String?
    var epsEstimateCurrentYear:String?
    var epsEstimateNextQuarter:String?
    var epsEstimateNextYear:String?
    var earningsShare:String?
    var errorIndicationReturnedForSymbolChangedInvalid:String?
    var exDividendDate:String?
    var fiveDayChartModule:BigBoardChartDataModule?
    var fiveYearChartModule:BigBoardChartDataModule?
    var fiftyDayMovingAverage:String?
    var highLimit:String?
    var historicalData:[BigBoardHistoricalData]?
    var holdingsGain:String?
    var holdingsGainPercent:String?
    var holdingsGainPercentRealtime:String?
    var holdingsGainRealtime:String?
    var holdingsValue:String?
    var holdingsValueRealtime:String?
    var lastTradeDate:String?
    var lastTradePriceOnly:String?
    var lastTradeRealTimeWithTime:String?
    var lastTradeTime:String?
    var lastTradeWithTime:String?
    var lifetimeChartModule:BigBoardChartDataModule?
    var lowLimit:String?
    var marketCapRealtime:String?
    var marketCapitalization:String?
    var moreInfo:String?
    var name:String?
    var notes:String?
    var oneDayChartModule:BigBoardChartDataModule?
    var oneMonthChartModule:BigBoardChartDataModule?
    var oneYearChartModule:BigBoardChartDataModule?
    var oneYearTargetPrice:String?
    var open:String?
    var orderBookRealtime:String?
    var pegRatio:String?
    var peRatio:String?
    var peRatioRealtime:String?
    var percentChangeFromYearHigh:String?
    var percentChange:String?
    var percentChangeFromFiftyDayMovingAverage:String?
    var percentChangeFromTwoHundredDayMovingAverage:String?
    var percentChangeFromYearLow:String?
    var previousClose:String?
    var priceBook:String?
    var priceEPSEstimateCurrentYear:String?
    var priceEPSEstimateNextYear:String?
    var pricePaid:String?
    var priceSales:String?
    var sharesOwned:String?
    var shortRatio:String?
    var stockExchange:String?
    var symbol:String?
    var threeMonthChartModule:BigBoardChartDataModule?
    var tickerTrend:String?
    var tradeDate:String?
    var twoHundredDayMovingAverage:String?
    var volume:String?
    var yearHigh:String?
    var yearLow:String?
    var yearRange:String?
```

### Retrieving Historical Data for a Stock in a Given Date Range

You can use any of these:

```swift
class BigBoardStock : Mappable {
    func mapHistoricalDataWithFiveDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapHistoricalDataWithTenDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapHistoricalDataWithThirtyDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
}
```

or define your own:

```swift
import BigBoard

let dateRange = BigBoardHistoricalDateRange(startDate: NSDate() - 7.days, endDate: NSDate() - 3.days)
stock.mapHistoricalDataWithRange(dateRange: dateRange, success: { 
    // The historical data has been mapped to the stock
    print(stock.historicalData.count)
}) { (error) in
    print(error)
}
```

Historical data items have the following properties:

```swift
class BigBoardHistoricalData: Mappable {
    var symbol:String?
    var date:String?
    var open:String?
    var high:String?
    var low:String?
    var close:String?
    var volume:String?
    var adjClose:String?
}
```

### Retrieving Chart Data for a Stock

There are currently seven different ways to retrieve chart data:

```swift
class BigBoardStock : Mappable {
    func mapOneDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapFiveDayChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapOneMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapThreeMonthChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapOneYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapFiveYearChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapLifetimeChartDataModule(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
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
    var dates:[NSDate]!
    var series:[BigBoardChartDataModuleSeries]!
}

class BigBoardChartDataModuleSeries: Mappable {
    var date:NSDate!
    var close:Double!
    var high:Double!
    var low:Double!
    var open:Double!
    var volume:Int!
}
```

## Retrieve Graph Images with Custom Trendlines

An image of a graph for any stock can easily be set to any UIImageView by calling this function:
```swift
import BigBoard

extension UIImageView {
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
    var symbol:String?
    var name:String?
    var exch:String?
    var type:String?
    var exchDisp:String?
    var typeDisp:String?
}

```

## Requirements

- iOS 8.0+
- xCode 7.3+

## Author

Dalton Hinterscher, daltonhint4@gmail.com

## License

BigBoard is available under the MIT license. See the LICENSE file for more info.
