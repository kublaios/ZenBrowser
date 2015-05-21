//
//  MenuViewController.swift
//  ZenBrowser
//
//  Created by Kubilay Erdogan on 14/05/15.
//  Copyright (c) 2015 kublaios. All rights reserved.
//

import Foundation

class MenuViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txt: UITextField?
    @IBOutlet weak var btnBack: UIButton?
    @IBOutlet weak var btnForward: UIButton?
    @IBOutlet weak var btnRefresh: UIButton?
    @IBOutlet weak var btnGoogle: UIButton?
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // a gesture recognizer to hide menu view when tapped to bg
        // TODO: expand this ability to top of the menu view (does not work around the circle icon)
        var tap = UITapGestureRecognizer(target: self, action: "bgViewTapped")
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func bgViewTapped() {
        // discourage buttons from triggering the bg gesture recognizer
        if self.btnBack?.state == UIControlState.Highlighted || self.btnForward?.state == UIControlState.Highlighted || self.btnRefresh?.state == UIControlState.Highlighted || self.btnGoogle?.state == UIControlState.Highlighted {
            return
        }
        self.hideSelf()
    }
    
    func hideSelf() {
        var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        appDel.draggingCoordinator?.draggableViewTouched(appDel.draggableView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.txt?.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    // MARK: IB Actions
    @IBAction func btnBackTapped(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("goBack", object: nil)
    }
    
    @IBAction func btnForwardTapped(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("goForward", object: nil)
    }
    
    @IBAction func btnRefreshTapped(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil)
        self.hideSelf()
    }
    
    @IBAction func btnGoogleTapped(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("process", object: nil, userInfo: [ "text": "g " + self.txt!.text ])
        self.hideSelf()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.txt?.resignFirstResponder()
        self.bgViewTapped()
        NSNotificationCenter.defaultCenter().postNotificationName("process", object: nil, userInfo: [ "text": self.txt!.text ])
        return true
    }
    
}