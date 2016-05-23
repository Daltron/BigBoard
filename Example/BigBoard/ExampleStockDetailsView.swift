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
    func rssFeedItemAtIndex(index:Int) -> BigBoardRSSFeedItem
    func rssFeedItemSelectedAtIndex(index:Int)
}

class ExampleStockDetailsView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate:ExampleStockDetailsViewDelegate?
    var graphImageView:UIImageView!
    var rssFeedTableView:UITableView!
    
    init(delegate:ExampleStockDetailsViewDelegate) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = delegate
        
        graphImageView = UIImageView()
        graphImageView.backgroundColor = UIColor.whiteColor()
        addSubview(graphImageView)
        
        graphImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.25)
        }
        
        rssFeedTableView = UITableView(frame: CGRectZero, style: .Grouped)
        rssFeedTableView.dataSource = self
        rssFeedTableView.delegate = self
        rssFeedTableView.rowHeight = 100.0
        addSubview(rssFeedTableView)
        
        rssFeedTableView.snp_makeConstraints { (make) in
            make.top.equalTo(graphImageView.snp_bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableViewDataSource and UITableViewDataSource Implementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.numberOfRSSFeedItems()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "ExampleCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: reuseIdentifier)
            cell?.textLabel?.numberOfLines = 2
            cell?.detailTextLabel?.numberOfLines = 0
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let feedItem = delegate!.rssFeedItemAtIndex(indexPath.row)
        cell.textLabel?.text = feedItem.title!
        cell.detailTextLabel?.text = feedItem.description!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        delegate!.rssFeedItemSelectedAtIndex(indexPath.row)
    }


}
