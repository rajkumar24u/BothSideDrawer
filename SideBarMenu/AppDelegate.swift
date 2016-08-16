//
//  AppDelegate.swift
//  SideBarMenu
//
//  Created by mac on 16/08/16.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainVc = storyboard.instantiateViewControllerWithIdentifier("ViewController")
        let leftVc = storyboard.instantiateViewControllerWithIdentifier("Left")
        let rightVc = storyboard.instantiateViewControllerWithIdentifier("Right")
        
        
        window = ASWindow(mainVC: mainVc, leftVC: leftVc, rightVC: rightVc)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


class ASWindow: UIWindow {
    
    var mainNVC: UINavigationController?
    var leftNVC: UINavigationController?
    var rightNVC: UINavigationController?
    var blackButton: UIButton?
    var isShowingLeft = false
    var isShowingRight = false
    
   init(mainVC mainVc: UIViewController, leftVC leftVc:UIViewController, rightVC rightVc:UIViewController) {
    
    super.init(frame: UIScreen.mainScreen().bounds)
    
        self.mainNVC = UINavigationController(rootViewController: mainVc)
        self.leftNVC = UINavigationController(rootViewController: leftVc)
        self.rightNVC = UINavigationController(rootViewController: rightVc)
        
        self.rootViewController = mainNVC
        
        self.leftNVC!.view.frame = CGRectMake(0, 0, 250, self.bounds.size.height)
        self.addSubview(self.leftNVC!.view)
    
    
        self.rightNVC!.view.frame = CGRectMake(self.bounds.width - 250, 0, 250, self.bounds.size.height)
        self.addSubview(self.rightNVC!.view)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ASWindow.orientationDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showLeft() {
        
        if self.mainNVC?.view.frame.origin.x == 0 {
            
            self.rightNVC?.view.hidden = true
            self.leftNVC?.view.hidden = false
            self.updateMainNVCFrameWithX(X: 250)
            
        }
        
        isShowingLeft = true
        
    }
    
    func showRight() {
        
        if self.mainNVC?.view.frame.origin.x == 0 {
            
            self.leftNVC?.view.hidden = true
            self.rightNVC?.view.hidden = false

            self.updateMainNVCFrameWithX(X: -250)
        }
        
        isShowingRight = true
    }
    
    func updateMainNVCFrameWithX(X x:CGFloat) {
        
        let updatedFrame = CGRectMake(x, 0, self.bounds.size.width, self.bounds.size.height)
        
        blackButton = UIButton(frame: self.bounds)
        blackButton?.backgroundColor = UIColor.blackColor()
        blackButton?.addTarget(self, action: #selector(ASWindow.tapped), forControlEvents: .TouchUpInside)
        blackButton?.alpha = 0.0
        self.addSubview(blackButton!)

        UIView.animateWithDuration(0.30) {
            self.mainNVC?.view.frame = updatedFrame
            self.blackButton?.frame = updatedFrame
            self.blackButton?.alpha = 0.15
        }
        
    }
    
    func tapped() {
        
        UIView.animateWithDuration(0.30, animations: {
            
            self.mainNVC?.view.frame = self.bounds
            self.blackButton?.frame = self.bounds
            self.blackButton?.alpha = 0.0

            }) { (completion) in
                
                self.blackButton?.removeFromSuperview()
                self.isShowingRight = false
                self.isShowingLeft = false
        }
        
    }
    
    func orientationDidChange() {
        
        if isShowingLeft == true {
            blackButton?.frame = CGRectMake(250, 0, self.bounds.size.width, self.bounds.size.height)
            self.leftNVC!.view.frame = CGRectMake(0, 0, 250, self.bounds.size.height)
        }
        
        if isShowingRight == true {
            blackButton?.frame = CGRectMake(-250, 0, self.bounds.size.width, self.bounds.size.height)
            self.rightNVC!.view.frame = CGRectMake(self.bounds.width - 250, 0, 250, self.bounds.size.height)
        }

        
        
        if UIDevice.currentDevice().orientation == .LandscapeRight || UIDevice.currentDevice().orientation == .LandscapeLeft {
            
            if isShowingLeft == true {
                self.leftNVC?.navigationBar.frame = CGRectMake(0, 0, 250, 32)
            }
            
            if isShowingRight == true {
                self.rightNVC?.navigationBar.frame = CGRectMake(0, 0, 250, 32)
            }

        } else {
            
            if isShowingLeft == true {
                self.leftNVC?.navigationBar.frame = CGRectMake(0, 0, 250, 64)
            }
            
            if isShowingRight == true {
                self.rightNVC?.navigationBar.frame = CGRectMake(0, 0, 250, 64)
            }

        }
    }
    
}














































