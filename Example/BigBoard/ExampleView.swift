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
    func stockAtIndex(_ index:Int) -> BigBoardStock
    func stockSelectedAtIndex(_ index:Int)
    func refreshControllPulled()
}

class ExampleView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleViewDelegate?
    var stocksTableView:UITableView!
    var refreshControl:UIRefreshControl!
    
    init(delegate:ExampleViewDelegate){
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.backgroundColor = UIColor.white
        
        stocksTableView = UITableView(frame: CGRect.zero, style: .plain)
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.rowHeight = 50.0
        addSubview(stocksTableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControllerPulled), for: .valueChanged)
        stocksTableView.addSubview(refreshControl)
        
        stocksTableView.snp.makeConstraints { (make) in
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfStocks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            let currentPriceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 25))
            currentPriceLabel.textAlignment = .right
            cell?.accessoryView = currentPriceLabel
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let stock = delegate!.stockAtIndex((indexPath as NSIndexPath).row)
        cell.textLabel?.text = stock.name!
        cell.detailTextLabel?.text = stock.symbol!
        let currentPriceLabel = cell.accessoryView as! UILabel!
        currentPriceLabel?.text = "$\(stock.lastTradePriceOnly!)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate!.stockSelectedAtIndex((indexPath as NSIndexPath).row)
    }

}
