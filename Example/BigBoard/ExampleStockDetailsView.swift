//
//  ExampleStockDetailsView.swift
//  BigBoard
//
//  Created by Dalton Hinterscher on 5/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

protocol ExampleStockDetailsViewDelegate : class {
    func numberOfRSSFeedItems() -> Int
    func rssFeedItemAtIndex(_ index:Int) -> BigBoardRSSFeedItem
    func rssFeedItemSelectedAtIndex(_ index:Int)
}

class ExampleStockDetailsView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleStockDetailsViewDelegate?
    var graphImageView:UIImageView!
    var rssFeedTableView:UITableView!
    
    init(delegate:ExampleStockDetailsViewDelegate) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.delegate = delegate
        
        graphImageView = UIImageView()
        graphImageView.backgroundColor = UIColor.white
        addSubview(graphImageView)
        
        graphImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        }
        
        rssFeedTableView = UITableView(frame: CGRect.zero, style: .grouped)
        rssFeedTableView.dataSource = self
        rssFeedTableView.delegate = self
        rssFeedTableView.rowHeight = 100.0
        addSubview(rssFeedTableView)
        
        rssFeedTableView.snp.makeConstraints { (make) in
            make.top.equalTo(graphImageView.snp.bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource and UITableViewDataSource Implementation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfRSSFeedItems()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
            cell?.textLabel?.numberOfLines = 2
            cell?.detailTextLabel?.numberOfLines = 0
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let feedItem = delegate!.rssFeedItemAtIndex((indexPath as NSIndexPath).row)
        cell.textLabel?.text = feedItem.title!
        cell.detailTextLabel?.text = feedItem.description!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate!.rssFeedItemSelectedAtIndex((indexPath as NSIndexPath).row)
    }


}
