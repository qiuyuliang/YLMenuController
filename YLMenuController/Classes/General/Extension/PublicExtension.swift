//
//  PublicExtension.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        var rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIButton {
    class func titleButton(frame: CGRect, text: NSString, target: AnyObject?, action: Selector) -> UIButton {
        var button = UIButton.buttonWithType(.Custom) as UIButton
        button.frame = frame
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        button.setTitle(text, forState: .Normal)
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel!.font = UIFont.systemFontOfSize(14)
        return button
    }
}