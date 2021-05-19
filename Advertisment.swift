//
//  Advertisement.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/12/21.
//

import SwiftUI
import GoogleMobileAds


// MARK: - GADBannerViewController

struct GADBannerViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        
        let testID = "ca-app-pub-3940256099942544/2934735716"
        let realID = "ca-app-pub-4144711857610576/2532378892"
        
        //banner
        view.adUnitID = testID
        view.rootViewController = viewController
        
        //view controller
        viewController.view.addSubview(view)
        //viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        viewController.view.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
        
        view.load(GADRequest())
        
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
