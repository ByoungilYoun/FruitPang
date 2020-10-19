//
//  AppDelegate.swift
//  FruitPang
//
//  Created by 윤병일 on 2020/09/22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()                          
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = LaunchViewController()
    window?.backgroundColor = .systemBackground
    window?.makeKeyAndVisible()
    return true
  }
}

