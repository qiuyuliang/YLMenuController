//
//  AccountManager.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

class AccountManager: NSObject {
    
    let loginCallback: () -> ()
    let logoutCallback: () -> ()
    
    init(loginCallback: () -> (), logoutCallback: () -> ()) {
        self.loginCallback = loginCallback
        self.logoutCallback = logoutCallback
    }
    
    func login() {
        self.loginCallback()
    }
    
    func logout() {
        self.logoutCallback()
    }
}
