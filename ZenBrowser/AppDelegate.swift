//
//  AppDelegate.swift
//  ZenBrowser
//
//  Created by Kubilay Erdogan on 13/05/15.
//  Copyright (c) 2015 kublaios. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CHDraggingCoordinatorDelegate {

    var window: UIWindow?
    var draggableView: CHDraggableView?
    var draggingCoordinator: CHDraggingCoordinator?
    var viewController: UIViewController?
    var activity: UIActivityIndicatorView?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // target window & view controller
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.viewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ViewController") as? UIViewController
        
        // start with a navigation controller
        var navCtl = UINavigationController(rootViewController: self.viewController!)
        self.window?.rootViewController = navCtl
        self.window?.makeKeyAndVisible()
        
        // initialize the draggable view
        self.draggableView = CHDraggableView(image: UIImage(named: "menu")!)
        self.draggableView?.tag = 1
        
        // initialize a dragging coordinator for the draggable view
        self.draggingCoordinator = CHDraggingCoordinator(window: self.window!, draggableViewBounds: self.draggableView!.bounds, closeView: nil)
        self.draggingCoordinator?.delegate = self
        self.draggingCoordinator?.snappingEdge = CHSnappingEdgeBoth
        self.draggableView?.delegate = self.draggingCoordinator!
        
        // activity indicator
        self.activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.activity?.hidesWhenStopped = true
        self.activity?.stopAnimating()
        var frame = self.activity!.frame
        var x = self.draggableView!.frame.origin.x + (self.draggableView!.frame.size.width / 2) - 10.0 // 10 represents half of the width of the activity indicator
        var y = self.draggableView!.frame.origin.y + (self.draggableView!.frame.size.height / 2) - 10.0
        frame.origin = CGPointMake(x, y)
        self.activity?.frame = frame
        self.draggableView?.addSubview(self.activity!)
        
        self.window?.addSubview(self.draggableView!)
        
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
        // TODO: Discourage draggable view from disappearing
        // MARK: Bugfix when draggable view disappears (happens if dragged over status bar)
        self.draggableView?.removeFromSuperview()
        if let draggable = self.draggableView {
            self.window?.addSubview(draggable)
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func draggingCoordinator(coordinator: CHDraggingCoordinator!, viewControllerForDraggableView draggableView: CHDraggableView!) -> UIViewController! {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MenuViewController") as! UIViewController
    }

}

