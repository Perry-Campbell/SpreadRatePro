//
//  AppDelegate.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/12/21.
//

import Foundation
import SwiftUI
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    GADMobileAds.sharedInstance().start(completionHandler: nil)

    return true
  }

}

