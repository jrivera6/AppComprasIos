//
//  AppDelegate.swift
//  AppCompras
//
//  Created by Jhonny Rivera on 5/28/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import CoreData
import SlideMenuControllerSwift
import SideMenuSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Principal")  as! UITabBarController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sideBar()
        return true
        
    }
    
//    func sideBar2(){
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//
//        let navigationController = UINavigationController()
//        navigationController.isNavigationBarHidden = true
//        navigationController.view.backgroundColor = .black
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let contentVC = storyboard.instantiateViewController(withIdentifier: "Principal") as! UITabBarController
//        let menuVC = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
//
//        contentVC.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
//
//        menuVC.mainViewController = contentVC
//
//        let navController = UINavigationController(rootViewController: contentVC)
//
//        let sideMC = SideMenuController(contentViewController: navController, menuViewController: menuVC)
//
//        navigationController.viewControllers = [sideMC]
//
//        window?.rootViewController = navigationController
//
//    }
    
    func sideBar(){
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        print("en el sidebar")
        
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        navigationController.view.backgroundColor = .white
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.bool(forKey: "isLogged") == true {
            
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuViewController
            
            
            
            
            mainViewController.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
            mainViewController.navigationItem.title = "Shopper"
//            mainViewController.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(AppDelegate.openCamera(_:))), animated: true)
            
//            print("en el selector \(#selector(openCamera(_:)))")
            
            //        mainViewController.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(changeTabWhenBack(_:)) )
            
            leftViewController.mainViewController = mainViewController
            
            
            //Settings NavigationController options
            let navController = UINavigationController(rootViewController: mainViewController)
            navController.navigationBar.barTintColor = UIColor(red:1.00, green:0.36, blue:0.18, alpha:1.0)
            navController.navigationBar.tintColor = .white
            navController.navigationBar.barStyle = .black
            
            
            
            let slideMenuController = SlideMenuController(mainViewController: navController, leftMenuViewController: leftViewController)
            navigationController.viewControllers = [slideMenuController]
            
        }else{
            
            let loginVC = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
            navigationController.viewControllers = [loginVC]
            
            
        }
        
        window?.rootViewController = navigationController
        
    }
    
    

    
//    @objc func openCamera(_ sender: UIBarButtonItem){
//
//        print("sender es: \(sender)")
//
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let EscanerQr = storyboard.instantiateViewController(withIdentifier: "Escaner") as! QRViewController
//        mainViewController.navigationController?.pushViewController(EscanerQr, animated: true)
//        mainViewController.selectedIndex = 1
//    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AppCompras")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

