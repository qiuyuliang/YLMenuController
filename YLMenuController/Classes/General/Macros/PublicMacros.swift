//
//  PublicMacros.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import Foundation
import UIKit

//十六进制
func HEXCOLOR(hexString: Int) -> UIColor {
    return UIColor(red: CGFloat((hexString & 0xFF0000) >> 16)/255.0, green: CGFloat((hexString & 0xFF00) >> 8)/255.0, blue: CGFloat(hexString & 0xFF)/255.0, alpha: 1)
}

func RGBACOLOR(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func kAppdelegate() -> AppDelegate {
    return UIApplication.sharedApplication().delegate as AppDelegate
}