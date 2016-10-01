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
    func searchResultStockAtIndex(_ index:Int) -> BigBoardSearchResultStock
    func searchTermChanged(searchTerm:String)
    func stockResultSelectedAtIndex(_ index:Int)
}

class ExampleAddStockView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleAddStockViewDelegate?
    var searchTextField:UITextField!
    var stocksTableView:UITableView!

    init(delegate:ExampleAddStockViewDelegate) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.backgroundColor = UIColor.white
        
        let searchBarView = UIView()
        addSubview(searchBarView)
        
        searchTextField = UITextField()
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .center
        searchTextField.placeholder = "Search:"
        searchTextField.addTarget(self, action: #selector(searchTermChanged), for: .allEditingEvents)
        searchBarView.addSubview(searchTextField)
        
        stocksTableView = UITableView(frame: CGRect.zero, style: .plain)
        stocksTableView.dataSource = self
        stocksTableView.delegate = self
        stocksTableView.rowHeight = 50.0
        addSubview(stocksTableView)
        
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView).offset(10)
            make.left.equalTo(searchBarView).offset(10)
            make.right.equalTo(searchBarView).offset(-10)
            make.bottom.equalTo(searchBarView).offset(-10)
        }
        
        stocksTableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfSearchResultStocks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            let exchangeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 25))
            exchangeLabel.textAlignment = .right
            cell?.accessoryView = exchangeLabel
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let stock = delegate!.searchResultStockAtIndex((indexPath as NSIndexPath).row)
        cell.textLabel?.text = stock.name!
        cell.detailTextLabel?.text = stock.symbol!
        let exchangeLabel = cell.accessoryView as! UILabel!
        exchangeLabel?.text = stock.exch!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate!.stockResultSelectedAtIndex((indexPath as NSIndexPath).row)
    }

}
