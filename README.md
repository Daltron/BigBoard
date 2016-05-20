# BigBoard

[![CI Status](http://img.shields.io/travis/Dalton/BigBoard.svg?style=flat)](https://travis-ci.org/Dalton/BigBoard)
[![Version](https://img.shields.io/cocoapods/v/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![License](https://img.shields.io/cocoapods/l/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)
[![Platform](https://img.shields.io/cocoapods/p/BigBoard.svg?style=flat)](http://cocoapods.org/pods/BigBoard)

BigBoard is the most powerful yet easy to use API for iOS for retrieving stock market and finance data from Yahoo's APIs.

## Features
- [x] Retreive a stock based on a stock symbol
- [x] Retrieve multiple stocks at the same time based on multiple stock symbols
- [x] Retrieve historical data for a stock for any custom date range
- [x] Retrieve chart data information for a stock that can easily be used in many charting libraries
- [x] Retrieve a list of stocks based on a search term
- [x] Comprehensive unit test coverage
- [x] Complete documentation

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

## Usage

### Mapping a single stock

```swift
import BigBoard

BigBoard.stockWithSymbol(symbol: "GOOG", success: { (stock) in
    // Do something with the stock
}) { (error) in
    print(error)    
}
```

### Mapping multiple stocks with one request

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

### Retrieving historical data for a stock in a given date range

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

### Retrieving chart data for a stock

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


### Retrieve a list of stocks based on a search term

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

Dalton, daltonhint4@gmail.com

## License

BigBoard is available under the MIT license. See the LICENSE file for more info.
