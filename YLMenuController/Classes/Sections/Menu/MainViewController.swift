//
//  MainViewController.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

enum ScrollPosion {
    case ScrollPositionDown
    case ScrollPositionUp
}

class MainViewController: FeedViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    var tableView: UITableView?
    var lastPostion: CGFloat = 0
    var scrollPosion: ScrollPosion?
    var isDecelerating: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var titleArray = ["推荐", "百家", "本地", "科技", "体育", "娱乐", "图片", "财经", "电台", "社会", "生活"]
        var scrollView = UIScrollView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44))
        scrollView.contentSize = CGSizeMake(5 + 55 * CGFloat(titleArray.count), 44);
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(scrollView)
        for var index = 0; index < titleArray.count; index++ {
            var titleButton = UIButton.titleButton(CGRectMake(5 + (35 + 20) * CGFloat(index), 0, 35, 44), text: titleArray[index] as String, target: self, action: "titleButtonAction:")
            titleButton.titleLabel!.font = UIFont.systemFontOfSize(16)
            scrollView.addSubview(titleButton)
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.tableView = UITableView(frame: CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44), style: .Plain)
        self.tableView!.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
    }
    
    func titleButtonAction(AnyObject) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(scrollView.contentOffset.y);
//        println(scrollView.contentOffset.y - lastPostion)
        if scrollView.contentOffset.y - lastPostion > 0 {
            println("向上")
            if scrollView.contentOffset.y < 44 {
                self.tableView!.frame = CGRectMake(0, 44 - scrollView.contentOffset.y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44 + scrollView.contentOffset.y)
                self.scrollPosion = .ScrollPositionUp
            }
        } else {
            println("向下")
            if scrollView.contentOffset.y < 44 {
                self.tableView!.frame = CGRectMake(0, 44 - scrollView.contentOffset.y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44 + scrollView.contentOffset.y)
                self.scrollPosion = .ScrollPositionDown
            }
            
        }
        lastPostion = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isDecelerating = true
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        isDecelerating = false
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.scrollPosion == .ScrollPositionDown {
            //向下滚动
            if self.tableView!.frame.origin.y < 44 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.tableView!.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44)
                })
            }
        } else {
            //向上滚动
            if self.tableView!.frame.origin.y < 44 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.tableView!.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
