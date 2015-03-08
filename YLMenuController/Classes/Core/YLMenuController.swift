//
//  YLMenuController.swift
//  YLMenuController
//
//  Created by 邱 育良 on 15/2/9.
//  Copyright (c) 2015年 Qiu Yuliang. All rights reserved.
//

import UIKit

enum MenuPanDirection {
    case MenuPanDirectionLeft
    case MenuPanDirectionRight
    case MenuPanDirectionDown
    case MenuPanDirectionUp
}

enum MenuPanCompletion {
    case MenuPanCompletionLeft
    case MenuPanCompletionRight
    case MenuPanCompletionMain
}

let kTopBarHeight: CGFloat = 64

class YLMenuController: UIViewController {
    
    var leftViewController: UIViewController?
    var mainViewController: UIViewController?
    var rightViewController: UIViewController?
    var subContainer: UIViewController?
    var vPanRecognizer: UIPanGestureRecognizer?
    var hPanRecognizer: UIPanGestureRecognizer?
    var panDirection: MenuPanDirection?
    var panCompletion = MenuPanCompletion.MenuPanCompletionMain
    var panVelocity: CGPoint?
    var panOriginX: CGFloat = 0.0
    var panOriginY: CGFloat = 0.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(rootViewController: UIViewController) {
        super.init()
        self.mainViewController = rootViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //返回按钮
        let temporaryBarButtonItem = UIBarButtonItem()
        temporaryBarButtonItem.title = "返回"
        self.navigationItem.backBarButtonItem = temporaryBarButtonItem
        
        //模糊背景
        let backgroundImageView = UIImageView(image: UIImage(named: "cover_blur.jpg"))
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(backgroundImageView)
        //左视图
        self.addChildViewController(self.leftViewController!)
        self.leftViewController!.view.frame = self.view.bounds
        self.leftViewController!.view.backgroundColor = UIColor(white: 1, alpha: 0)
//        self.leftViewController!.view.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.leftViewController!.view)
        self.leftViewController!.didMoveToParentViewController(self)
        //右视图
        self.addChildViewController(self.rightViewController!)
        self.rightViewController!.view.frame = self.view.bounds
        self.rightViewController!.view.backgroundColor = UIColor(white: 1, alpha: 0)
//        self.rightViewController!.view.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.rightViewController!.view)
        self.rightViewController!.didMoveToParentViewController(self)
        //主视图子容器
        self.subContainer = UIViewController()
        self.addChildViewController(self.subContainer!)
        self.subContainer!.view.frame = self.view.bounds
        self.subContainer!.view.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(self.subContainer!.view)
        self.subContainer!.didMoveToParentViewController(self)
        //顶部栏
        self.topBarView()
        //主视图
        self.addChildViewController(self.mainViewController!)
        self.mainViewController!.view.frame = CGRectMake(0, kTopBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
        self.mainViewController!.view.backgroundColor = UIColor(white: 1, alpha: 0)
        self.subContainer!.view.addSubview(self.mainViewController!.view)
        self.mainViewController!.didMoveToParentViewController(self.subContainer)
        //水平方向手势
        self.hPanRecognizer = UIPanGestureRecognizer(target: self, action: "respondsToHPanGesture:")
        self.subContainer!.view.addGestureRecognizer(self.hPanRecognizer!)
//        self.hPanRecognizer!.enabled = false
        //垂直方向手势
        self.vPanRecognizer = UIPanGestureRecognizer(target: self, action: "respondsToVPanGesture:")
        self.view.addGestureRecognizer(self.vPanRecognizer!)
        self.vPanRecognizer!.enabled = false//默认关闭垂直手势
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        struct Static {
            static var isFirstLaunch: Bool = false
        }
        self.navigationController!.setNavigationBarHidden(true, animated: Static.isFirstLaunch)
        Static.isFirstLaunch = true
    }
    
    func topBarView() {
        //新闻Logo
        let logoButton = UIButton.buttonWithType(.Custom) as UIButton
        logoButton.setImage(UIImage(named: "news_logo.png"), forState: .Normal)
        logoButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(logoButton)
        logoButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: logoButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: logoButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 26))
        //logo下箭头
        let logodownButton = UIButton.buttonWithType(.Custom) as UIButton
        logodownButton.setImage(UIImage(named: "icon_logodown.png"), forState: .Normal)
        logodownButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(logodownButton)
        logodownButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: logodownButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: logodownButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 42))
        //封面上箭头
        let coverArrowButton = UIButton.buttonWithType(.Custom) as UIButton
        coverArrowButton.setImage(UIImage(named: "cover_arrow.png"), forState: .Normal)
        coverArrowButton.addTarget(self, action: "toggleUp:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(coverArrowButton)
        coverArrowButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: coverArrowButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.subContainer!.view.addConstraint(NSLayoutConstraint(item: coverArrowButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.subContainer!.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -30))
        //左一
        let interestButton = UIButton.buttonWithType(.Custom) as UIButton
        interestButton.setImage(UIImage(named: "title_bar_interestmodel.png"), forState: .Normal)
//        interestButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(interestButton)
        interestButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        //左二
        let searchButton = UIButton.buttonWithType(.Custom) as UIButton
        searchButton.setImage(UIImage(named: "title_search.png"), forState: .Normal)
        //        interestButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(searchButton)
        searchButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //右二
        let addButton = UIButton.buttonWithType(.Custom) as UIButton
        addButton.setImage(UIImage(named: "title_add.png"), forState: .Normal)
        //        interestButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(addButton)
        addButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        //右一
        let headButton = UIButton.buttonWithType(.Custom) as UIButton
        headButton.setImage(UIImage(named: "title_head.png"), forState: .Normal)
        //        interestButton.addTarget(self, action: "toggleDown:", forControlEvents: .TouchUpInside)
        self.subContainer!.view.addSubview(headButton)
        headButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var views = ["interestButton": interestButton, "searchButton": searchButton, "addButton": addButton, "headButton": headButton]
        self.subContainer!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[interestButton]-10-[searchButton]->=100-[addButton]-10-[headButton]-5-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.subContainer!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[interestButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.subContainer!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[searchButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.subContainer!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[addButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        self.subContainer!.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-25-[headButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
        }
    
    func toggleDown(sender: AnyObject) {
        self.leftViewController!.view.hidden = true
        self.rightViewController!.view.hidden = true
        var logoButton = sender as UIButton
        logoButton.setTranslatesAutoresizingMaskIntoConstraints(true)
//        self.displayButtonAnimation(logoButton)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.mainViewController!.view.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
            }, completion: { (finished: Bool) -> Void in
                if finished {
                    self.hPanRecognizer!.enabled = false
                    self.vPanRecognizer!.enabled = true
                }
        })
    }
    
    func displayButtonAnimation(button: UIButton) {
        var scaleTrasform = CATransform3DMakeScale(2, 2, 1)
        var translation = CATransform3DMakeTranslation(0, 44, 0)
        var concat = CATransform3DConcat(scaleTrasform, translation)
        button.layer.transform = concat
        var animation = CABasicAnimation()
        animation.keyPath = "transform"
        animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(1, 1, 1))
        animation.toValue = NSValue(CATransform3D: concat)
        animation.duration = 0.25
        button.layer.addAnimation(animation, forKey: "basic")
    }
    
    func toggleUp(AnyObject) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.mainViewController!.view.frame = CGRectMake(0, kTopBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
            }, completion: { (finished: Bool) -> Void in
                if finished {
                    self.hPanRecognizer!.enabled = false
                    self.vPanRecognizer!.enabled = true
                }
        })
    }
    /*
    *垂直手势
    */
    func respondsToVPanGesture(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            panOriginY = self.mainViewController!.view.frame.origin.y
            panVelocity = CGPointZero
            if recognizer.velocityInView(self.view).y > 0 {
                panDirection = .MenuPanDirectionDown
            } else {
                panDirection = .MenuPanDirectionUp
            }
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            var velocity = recognizer.velocityInView(self.view)
            if velocity.x * panVelocity!.x + velocity.y * panVelocity!.y < 0 {
                panDirection = (panDirection == .MenuPanDirectionDown) ? .MenuPanDirectionUp : .MenuPanDirectionDown
            }
            panVelocity = velocity
            var translation = recognizer.translationInView(self.view)
            self.mainViewController!.view.frame = CGRectMake(0, panOriginY + translation.y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
        } else if recognizer.state == UIGestureRecognizerState.Ended {
            if panDirection == .MenuPanDirectionUp {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.mainViewController!.view.frame = CGRectMake(0, kTopBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
                    }, completion: { (finished: Bool) -> Void in
                        if finished {
                            self.hPanRecognizer!.enabled = true
                            self.vPanRecognizer!.enabled = false
                        }
                })
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.mainViewController!.view.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - kTopBarHeight)
                    }, completion: { (finished: Bool) -> Void in
                        if finished {
//                            self.panCompletion = .MenuPanCompletionLeft
                        }
                })
            }
        }
    }
    /*
    *水平手势
    */
    func respondsToHPanGesture(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            panOriginX = self.subContainer!.view.frame.origin.x
            panVelocity = CGPointZero
            if recognizer.velocityInView(self.view).x > 0 {
                panDirection = .MenuPanDirectionRight
            } else {
                panDirection = .MenuPanDirectionLeft
            }
        } else if recognizer.state == UIGestureRecognizerState.Changed {
            var velocity = recognizer.velocityInView(self.view)
            if velocity.x * panVelocity!.x + velocity.y * panVelocity!.y < 0 {
                panDirection = (panDirection == .MenuPanDirectionRight) ? .MenuPanDirectionLeft : .MenuPanDirectionRight
            }
            panVelocity = velocity
            var translation = recognizer.translationInView(self.view)
            self.subContainer!.view.frame = CGRectMake(panOriginX + translation.x, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
            if panOriginX + translation.x > 0 {
                self.leftViewController!.view.hidden = false
                self.rightViewController!.view.hidden = true
            } else if panOriginX + translation.x < 0 {
                self.leftViewController!.view.hidden = true
                self.rightViewController!.view.hidden = false
            }
        } else if recognizer.state == UIGestureRecognizerState.Ended {
            if panCompletion == .MenuPanCompletionMain {
                if panDirection == .MenuPanDirectionLeft {
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.subContainer!.view.frame = CGRectMake(-280, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
                        }, completion: { (finished: Bool) -> Void in
                        if finished {
                            self.panCompletion = .MenuPanCompletionRight
                        }
                    })
                } else {
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.subContainer!.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 40, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
                        }, completion: { (finished: Bool) -> Void in
                            if finished {
                                self.panCompletion = .MenuPanCompletionLeft
                            }
                    })
                }
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.subContainer!.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
                    }, completion: { (finished: Bool) -> Void in
                        if finished {
                            self.panCompletion = .MenuPanCompletionMain
                            self.leftViewController!.view.hidden = true
                            self.rightViewController!.view.hidden = true
                        }
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
