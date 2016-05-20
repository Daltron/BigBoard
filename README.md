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
- [x] Retrieve a list of stocks based on a given search term
- [x] Comprehensive unit test coverage
- [x] Complete documentation

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

### Retrieving historical data for a stock in a given date range

You can use any of these:

```swift

class BigBoardStock : Mappable {
    func mapHistoricalDataWithFiveDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapHistoricalDataWithTenDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
    func mapHistoricalDataWithThirtyDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request?
}
```

or make your own:

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

## Requirements

## Installation

BigBoard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BigBoard"
```

## Author

Dalton, daltonhint4@gmail.com

## License

BigBoard is available under the MIT license. See the LICENSE file for more info.
