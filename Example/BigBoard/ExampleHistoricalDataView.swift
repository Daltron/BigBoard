//
//  ExampleHistoricalDataView.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

protocol ExampleHistoricalDataViewDelegate : class {
    
}

class ExampleHistoricalDataView: UIView {

    weak var delegate:ExampleHistoricalDataViewDelegate?
    
    init(delegate:ExampleHistoricalDataViewDelegate) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
