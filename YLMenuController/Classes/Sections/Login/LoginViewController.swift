//
//  LoginViewController.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = RGBACOLOR(35, 154, 225, 1)
        //头像
        var portraitView = UIImageView(image: UIImage(named: "portrait"))
        portraitView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(portraitView)
        self.view.addConstraint(NSLayoutConstraint(item: portraitView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: portraitView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -100))
        //用户名
        var usernameTextField = UITextField()
        var usernamePlaceholder = NSAttributedString(string: "用户名", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        usernameTextField.attributedPlaceholder = usernamePlaceholder
        usernameTextField.tintColor = UIColor.whiteColor()
        usernameTextField.textColor = UIColor.whiteColor()
        //        usernameTextField.font = UIFont
        usernameTextField.contentVerticalAlignment = .Center
        usernameTextField.clearButtonMode = .WhileEditing
        usernameTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view .addSubview(usernameTextField)
        //密码
        var passwordTextField = UITextField()
        var passwordPlaceholder = NSAttributedString(string: "密 码", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordTextField.attributedPlaceholder = passwordPlaceholder
        passwordTextField.tintColor = UIColor.whiteColor()
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        passwordTextField.clearButtonMode = .WhileEditing
        passwordTextField.setTranslatesAutoresizingMaskIntoConstraints(false)
        passwordTextField.secureTextEntry = true
        self.view.addSubview(passwordTextField)
        //登录
        var button = UIButton.buttonWithType(.Custom) as UIButton
        button.setTitle("登     录", forState: .Normal)
        button.setBackgroundImage(UIImage.imageWithColor(RGBACOLOR(36.5, 162, 242, 1)), forState: .Normal)
        button.addTarget(self, action: "loginAction:", forControlEvents: .TouchUpInside)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(button)
        //布局
        
        var views = ["portraitView": portraitView, "usernameTextField": usernameTextField, "passworTextField": passwordTextField, "button": button]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[portraitView]-10-[usernameTextField(44)]-10-[passworTextField(44)]-10-[button(44)]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[usernameTextField]-20-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[passworTextField]-20-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[button]-20-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        
        var forgetButton = self.titleButton(CGRectZero, text: "忘记密码", target: self, action: "forgetAction:")
        forgetButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(forgetButton)
        
        var registerButton = self.titleButton(CGRectZero, text: "新用户", target: self, action: "registerAction:")
        registerButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(registerButton)
        
        views = ["forgetButton": forgetButton, "registerButton": registerButton]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[forgetButton]->=50-[registerButton]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[forgetButton]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[registerButton]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
    }
    
    func loginAction(AnyObject) {
        kAppdelegate().accountManager!.login()
    }
    
    func forgetAction(AnyObject) {
        
    }
    
    func registerAction(AnyObject) {
        
    }
    
    func titleButton(frame: CGRect, text: NSString, target: AnyObject?, action: Selector) -> UIButton {
        var button = UIButton.buttonWithType(.Custom) as UIButton
        button.frame = frame
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        button.setTitle(text, forState: .Normal)
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        button.titleLabel!.font = UIFont.systemFontOfSize(14)
        return button
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
