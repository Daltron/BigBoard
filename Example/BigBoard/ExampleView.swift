//
//  ExampleView.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

protocol ExampleViewDelegate : class {
    func numberOfStocks() -> Int
    func stockAtIndex(index:Int) -> BigBoardStock
    func stockSelectedAtIndex(index:Int)
    func refreshControllPulled()
}

class ExampleView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleViewDelegate?
    var stocksTableView:UITableView!
    var refreshControl:UIRefreshControl!
    
    init(delegate:ExampleViewDelegate){
        super.init(frame: CGRectZero)
        self.delegate = delegate
        self.backgroundColor = UIColor.whiteColor()
        
        stocksTableView = UITableView(frame: CGRectZero, style: .Plain)
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.rowHeight = 50.0
        addSubview(stocksTableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControllerPulled), forControlEvents: .ValueChanged)
        stocksTableView.addSubview(refreshControl)
        
        stocksTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshControllerPulled(){
        delegate!.refreshControllPulled()
    }
    
    // MARK: UITableViewDataSource and UITableViewDataSource Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfStocks()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
            let currentPriceLabel = UILabel(frame: CGRectMake(0, 0, 150, 25))
            currentPriceLabel.textAlignment = .Right
            cell?.accessoryView = currentPriceLabel
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let stock = delegate!.stockAtIndex(indexPath.row)
        cell.textLabel?.text = stock.name!
        cell.detailTextLabel?.text = stock.symbol!
        let currentPriceLabel = cell.accessoryView as! UILabel!
        currentPriceLabel.text = "$\(stock.lastTradePriceOnly!)"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        delegate!.stockSelectedAtIndex(indexPath.row)
    }

}
