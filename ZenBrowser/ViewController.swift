//
//  ViewController.swift
//  ZenBrowser
//
//  Created by Kubilay Erdogan on 13/05/15.
//  Copyright (c) 2015 kublaios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var browser: UIWebView!
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // hide the navbar, not needed
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // initialize the notifications for draggable menu buttons
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "process:", name: "process", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goBack:", name: "goBack", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goForward:", name: "goForward", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh:", name: "refresh", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.appDel.activity?.startAnimating()
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.browser.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.google.com")!))
            })
        })
    }
    
    func process(object: AnyObject?) {
        var ntf = object as! NSNotification
        var url = "http://www.google.com"
        if let dict = ntf.userInfo {
            if (dict["text"] as! NSString).hasPrefix("g ") {
                // if the passed string starts with "g ", make a google search
                url = "https://www.google.com.tr/search?q=" + (dict["text"] as! NSString).substringFromIndex(2)
                url = url.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
            } else {
                // if the passed string does not start with "g ", then try to initalize as a URL
                url = dict["text"] as! String
                if !(url as NSString).hasPrefix("http://") && !(url as NSString).hasPrefix("https://") {
                    url = "http://" + url
                }
            }
        }
        // latest checks for the URL
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        if let candidateURL = NSURL(string: url) {
            if candidateURL.scheme != nil && candidateURL.host != nil {
                self.browser.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            }
        }
    }
    
    func goBack(object: AnyObject?) {
        self.browser.goBack()
    }
    
    func goForward(object: AnyObject?) {
        self.browser.goForward()
    }
    
    func refresh(object: AnyObject?) {
        self.browser.reload()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.appDel.activity?.startAnimating()
        })
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.appDel.activity?.stopAnimating()
    }

}

