//
//  LeftViewController.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var button = UIButton.buttonWithType(.Custom) as UIButton
        button.setTitle("Logout", forState: .Normal)
        button.showsTouchWhenHighlighted = true
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(self, action: "logoutAction:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
    }
    
    func logoutAction(AnyObject) {
        kAppdelegate().accountManager!.logout()
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
