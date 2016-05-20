//
//  ExampleHistoricalDataView.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Charts

protocol ExampleHistoricalDataViewDelegate : class {
    
}

class ExampleHistoricalDataView: UIView, ChartViewDelegate {

    weak var delegate:ExampleHistoricalDataViewDelegate?
    var lineChartView:LineChartView!
    
    init(delegate:ExampleHistoricalDataViewDelegate) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = delegate
        
        lineChartView = LineChartView()
        lineChartView.delegate = self
        lineChartView.noDataTextDescription = "You need to provide data for the chart."
        addSubview(lineChartView)
        
        lineChartView.snp_makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.75)
            make.height.equalTo(self).multipliedBy(0.5)
            make.center.equalTo(self)
        }
        
        var values:[ChartDataEntry] = []
        
        for var i = 1; i <= 5; i++ {
            values.append(ChartDataEntry(value: Double(10 * i), xIndex: i - 1))
        }
    
        let data = LineChartDataSet(yVals: values, label: "Apple")
        let chartData = LineChartData(xVals: ["Mon", "Tues", "Wednesday"], dataSets: [data])
        lineChartView.data = chartData
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
