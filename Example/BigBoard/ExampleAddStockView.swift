//
//  ExampleAddStockView.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/20/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

protocol ExampleAddStockViewDelegate : class {
    func numberOfSearchResultStocks() -> Int
    func searchResultStockAtIndex(index:Int) -> BigBoardSearchResultStock
    func searchTermChanged(searchTerm searchTerm:String)
    func stockResultSelectedAtIndex(index:Int)
}

class ExampleAddStockView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleAddStockViewDelegate?
    var searchTextField:UITextField!
    var stocksTableView:UITableView!

    init(delegate:ExampleAddStockViewDelegate) {
        super.init(frame: CGRectZero)
        self.delegate = delegate
        self.backgroundColor = UIColor.whiteColor()
        
        let searchBarView = UIView()
        addSubview(searchBarView)
        
        searchTextField = UITextField()
        searchTextField.borderStyle = .RoundedRect
        searchTextField.textAlignment = .Center
        searchTextField.placeholder = "Search:"
        searchTextField.addTarget(self, action: #selector(searchTermChanged), forControlEvents: .AllEditingEvents)
        searchBarView.addSubview(searchTextField)
        
        stocksTableView = UITableView(frame: CGRectZero, style: .Plain)
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.rowHeight = 50.0
        addSubview(stocksTableView)
        
        searchBarView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(50)
        }
        
        searchTextField.snp_makeConstraints { (make) in
            make.top.equalTo(searchBarView).offset(10)
            make.left.equalTo(searchBarView).offset(10)
            make.right.equalTo(searchBarView).offset(-10)
            make.bottom.equalTo(searchBarView).offset(-10)
        }
        
        stocksTableView.snp_makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp_bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchTermChanged() {
        delegate!.searchTermChanged(searchTerm: searchTextField.text!)
    }
    
    // MARK: UITableViewDataSource and UITableViewDataSource Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfSearchResultStocks()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
            let exchangeLabel = UILabel(frame: CGRectMake(0, 0, 150, 25))
            exchangeLabel.textAlignment = .Right
            cell?.accessoryView = exchangeLabel
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let stock = delegate!.searchResultStockAtIndex(indexPath.row)
        cell.textLabel?.text = stock.name!
        cell.detailTextLabel?.text = stock.symbol!
        let exchangeLabel = cell.accessoryView as! UILabel!
        exchangeLabel.text = stock.exch!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        delegate!.stockResultSelectedAtIndex(indexPath.row)
    }

}
