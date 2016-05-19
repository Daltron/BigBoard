//
//  ExampleHistoricalDataViewController.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ExampleHistoricalDataViewController: UIViewController, ExampleHistoricalDataViewDelegate {

    var model:ExampleHistoricalDataModel!
    var exampleView:ExampleHistoricalDataView!
    
    init(model:ExampleHistoricalDataModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
        exampleView = ExampleHistoricalDataView(delegate: self)
        view = exampleView
        title = model.stock.name!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: ExampleHistoricalDataViewDelegate Implementation
    
    
    
}
