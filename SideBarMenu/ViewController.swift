//
//  ViewController.swift
//  SideBarMenu
//
//  Created by mac on 16/08/16.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func left() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        (appDelegate.window as! ASWindow).showLeft()
        
    }
    
    
    @IBAction func right() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        (appDelegate.window as! ASWindow).showRight()

    }


}

