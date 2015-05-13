//
//  ViewController.swift
//  ZenBrowser
//
//  Created by Kubilay Erdogan on 13/05/15.
//  Copyright (c) 2015 kublaios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var browser: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.browser.scalesPageToFit = true
        self.browser.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.kubilayerdogan.net")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

