//
//  BigBoardStock.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 4/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class BigBoardStock: NSObject, Mappable {

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
    var lowLimit:String?
    var marketCapRealtime:String?
    var marketCapitalization:String?
    var moreInfo:String?
    var name:String?
    var notes:String?
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
    var tickerTrend:String?
    var tradeDate:String?
    var twoHundredDayMovingAverage:String?
    var volume:String?
    var yearHigh:String?
    var yearLow:String?
    var yearRange:String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
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
    class func invalidSymbolsForStocks(stocks stocks:[BigBoardStock]) -> [String] {
        var invalidSymbols:[String] = []
        for stock in stocks {
            if stock.isReal() == false {
                invalidSymbols.append(stock.symbol!.uppercaseString)
            }
        }
        
        return invalidSymbols
    }
    
    /*  Determines wether or not the stock is real. Even if an incorrect stock symbol is provided to Yahoo's API,
        it will return a stock object that seems real but has nearly all null values. Checking the name allows us to know if the
        stock actually exists.
        See Example: http://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20('FAKESTOCK')&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
    */
    func isReal() -> Bool {
        return name != nil
    }
    
    /*  Fetches and maps historical data points based on the provided date range
        @param dateRange: The date range that the historical data points will fall in.
    */
    func mapHistoricalData(dateRange dateRange:BigBoardHistoricalDateRange, success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request? {
        
        return BigBoardRequestManager.mapHistoricalDataForStock(stock: self, dateRange: dateRange, success: { (historicalData:[BigBoardHistoricalData]) in
            self.historicalData = historicalData;
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
    
    func mapHistoricalDataWithFiveDayRange(success:(() -> Void)?, failure:(BigBoardError) -> Void) -> Request? {
        
        let dateRange = BigBoardHistoricalDateRange.fiveDayRange()
        
        return BigBoardRequestManager.mapHistoricalDataForStock(stock: self, dateRange: dateRange, success: { (historicalData:[BigBoardHistoricalData]) in
            self.historicalData = historicalData;
            if let success = success {
                success()
            }
        }, failure: failure)
        
    }
}
