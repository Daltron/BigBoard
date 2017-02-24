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
import Alamofire

open class BigBoardStock: Mappable {

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
    
    required public init?(map: Map) {
        mapping(map: map)
    }
    
    open func mapping(map: Map) {
        afterHoursChangeRealtime <- map["AfterHoursChangeRealtime"]
        annualizedGain <- map["AnnualizedGain"]
        ask <- map["Ask"]
        askRealTime <- map["AskRealtime"]
        averageDailyVolume <- map["AverageDailyVolume"]
        bid <- map["Bid"]
        bidRealTime <- map["BidRealtime"]
        bookValue <- map["BookValue"]
        change <- map["Change"]
        changeFromFiftyDayMovingAverage <- map["ChangeFromFiftydayMovingAverage"]
        changeFromTwoHundredDayMovingAverage <- map["ChangeFromTwoHundreddayMovingAverage"]
        changeFromYearHigh <- map["ChangeFromYearHigh"]
        changeFromYearLow <- map["ChangeFromYearLow"]
        changePercentRealtime <- map["ChangePercentRealtime"]
        changeRealTime <- map["ChangeRealtime"]
        changePercentChange <- map["Change_PercentChange"]
        changeInPercent <- map["ChangeinPercent"]
        commission <- map["Commission"]
        currency <- map["Currency"]
        daysHigh <- map["DaysHigh"]
        daysLow <- map["DaysLow"]
        daysRange <- map["DaysRange"]
        daysRangeRealTime <- map["DaysRangeRealtime"]
        daysValueChange <- map["DaysValueChange"]
        daysValueChangeRealTime <- map["DaysValueChangeRealtime"]
        dividendPayDate <- map["DividendPayDate"]
        dividendShare <- map["DividendShare"]
        dividendYield <- map["DividendYield"]
        ebitda <- map["EBITDA"]
        epsEstimateCurrentYear <- map["EPSEstimateCurrentYear"]
        epsEstimateNextQuarter <- map["EPSEstimateNextQuarter"]
        epsEstimateNextYear <- map["EPSEstimateNextYear"]
        earningsShare <- map["EarningsShare"]
        errorIndicationReturnedForSymbolChangedInvalid <- map["ErrorIndicationreturnedforsymbolchangedinvalid"]
        exDividendDate <- map["ExDividendDate"]
        fiftyDayMovingAverage <- map["FiftydayMovingAverage"]
        highLimit <- map["HighLimit"]
        holdingsGain <- map["HoldingsGain"]
        holdingsGainPercent <- map["HoldingsGainPercent"]
        holdingsGainPercentRealtime <- map["HoldingsGainPercentRealtime"]
        holdingsGainRealtime <- map["HoldingsGainRealtime"]
        holdingsValue <- map["HoldingsValue"]
        holdingsValueRealtime <- map["HoldingsValueRealtime"]
        lastTradeDate <- map["LastTradeDate"]
        lastTradePriceOnly <- map["LastTradePriceOnly"]
        lastTradeRealTimeWithTime <- map["LastTradeRealtimeWithTime"]
        lastTradeTime <- map["LastTradeTime"]
        lastTradeWithTime <- map["LastTradeWithTime"]
        lowLimit <- map["LowLimit"]
        marketCapRealtime <- map["MarketCapRealtime"]
        marketCapitalization <- map["MarketCapitalization"]
        moreInfo <- map["MoreInfo"]
        name <- map["Name"]
        notes <- map["Notes"]
        oneYearTargetPrice <- map["OneyrTargetPrice"]
        open <- map["Open"]
        orderBookRealtime <- map["OrderBookRealtime"]
        pegRatio <- map["PEGRatio"]
        peRatio <- map["PERatio"]
        peRatioRealtime <- map["PERatioRealtime"]
        percentChangeFromYearHigh <- map["PercebtChangeFromYearHigh"]
        percentChange <- map["PercentChange"]
        percentChangeFromFiftyDayMovingAverage <- map["PercentChangeFromFiftydayMovingAverage"]
        percentChangeFromTwoHundredDayMovingAverage <- map["PercentChangeFromTwoHundreddayMovingAverage"]
        percentChangeFromYearLow <- map["PercentChangeFromYearLow"]
        previousClose <- map["PreviousClose"]
        priceBook <- map["PriceBook"]
        priceEPSEstimateCurrentYear <- map["PriceEPSEstimateCurrentYear"]
        priceEPSEstimateNextYear <- map["PriceEPSEstimateNextYear"]
        pricePaid <- map["PricePaid"]
        priceSales <- map["PriceSales"]
        sharesOwned <- map["SharesOwned"]
        shortRatio <- map["ShortRatio"]
        stockExchange <- map["StockExchange"]
        symbol <- map["Symbol"]
        tickerTrend <- map["TickerTrend"]
        tradeDate <- map["TradeDate"]
        twoHundredDayMovingAverage <- map["TwoHundreddayMovingAverage"]
        volume <- map["Volume"]
        yearHigh <- map["YearHigh"]
        yearLow <- map["YearLow"]
        yearRange <- map["YearRange"]
    }
    
    
    /*  Returns an array of stock symbols that were invalid based on the stocks param passed in.
        @param stocks: An array of stocks to check for invalidity
    */
    
    open class func invalidSymbolsForStocks(stocks:[BigBoardStock]) -> [String] {
        var invalidSymbols:[String] = []
        for stock in stocks {
            if stock.isReal() == false {
                invalidSymbols.append(stock.symbol!.uppercased())
            }
        }
        
        return invalidSymbols
    }
    
    
    /*  Determines wether or not the stock is real. Even if an incorrect stock symbol is provided to Yahoo's API,
        it will return a stock object that seems real but has nearly all null values. Checking the name allows us to know if the
        stock actually exists.
        See Example: https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('FAKESTOCK')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
    */
    
    open func isReal() -> Bool {
        return name != nil
    }
    
    
    /*  Fetches and maps historical data points based on the provided date range.
        @param dateRange: The date range that the historical data points will fall in.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapHistoricalDataWithRange(dateRange:BigBoardHistoricalDateRange, success: (() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        
        return BigBoardRequestManager.mapHistoricalDataForStock(stock: self, dateRange: dateRange, success: { (historicalData:[BigBoardHistoricalData]) in
            self.historicalData = historicalData;
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    
    /*  Fetches and maps historical data points based on the previous five days. Today is not included in this range as YQL does not have 
        a historical data point for it yet.
        @param dateRange: The date range that the historical data points will fall in.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
     */
    
    open func mapHistoricalDataWithFiveDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        let dateRange = BigBoardHistoricalDateRange.fiveDayRange()
        return mapHistoricalDataWithRange(dateRange: dateRange, success: success, failure: failure)
    }
    
    
    /*  Fetches and maps historical data points based on the previous ten days. Today is not included in this range as YQL does not have
        a historical data point for it yet.
        @param dateRange: The date range that the historical data points will fall in.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
     */
    
    open func mapHistoricalDataWithTenDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        let dateRange = BigBoardHistoricalDateRange.tenDayRange()
        return mapHistoricalDataWithRange(dateRange: dateRange, success: success, failure: failure)
    }
    
    
    /*  Fetches and maps historical data points based on the previous thirty days. Today is not included in this range as YQL does not have
        a historical data point for it yet.
        @param dateRange: The date range that the historical data points will fall in.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
     */

    open func mapHistoricalDataWithThirtyDayRange(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        let dateRange = BigBoardHistoricalDateRange.thirtyDayRange()
        return mapHistoricalDataWithRange(dateRange: dateRange, success: success, failure: failure)
    }
    
    
    /*  Fetches and maps the oneDayChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapOneDayChartDataModule(_ success: (() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .OneDay, success: { (module:BigBoardChartDataModule) in
            self.oneDayChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    
    /*  Fetches and maps the fiveDayChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapFiveDayChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .FiveDay, success: { (module:BigBoardChartDataModule) in
            self.fiveDayChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }

    
    /*  Fetches and maps the oneDayChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapOneMonthChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .OneMonth, success: { (module:BigBoardChartDataModule) in
            self.oneMonthChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }

    
    /*  Fetches and maps the threeMonthChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapThreeMonthChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .ThreeMonth, success: { (module:BigBoardChartDataModule) in
            self.threeMonthChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    
    /*  Fetches and maps the oneYearChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapOneYearChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .OneYear, success: { (module:BigBoardChartDataModule) in
            self.oneYearChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    
    /*  Fetches and maps the fiveYearChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapFiveYearChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .FiveYear, success: { (module:BigBoardChartDataModule) in
            self.fiveYearChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    
    /*  Fetches and maps the lifetimeChartModule object.
        @param success: The callback that is called if the mapping was successfull
        @param failure: The callback that is called if the mapping failed or if the stock that called this method is not valid
    */
    
    open func mapLifetimeChartDataModule(_ success:(() -> Void)?, failure:@escaping (BigBoardError) -> Void) -> DataRequest? {
        return BigBoardRequestManager.mapChartDataModuleForStockWithSymbol(symbol: self.symbol!, range: .Lifetime, success: { (module:BigBoardChartDataModule) in
            self.lifetimeChartModule = module
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }

}
