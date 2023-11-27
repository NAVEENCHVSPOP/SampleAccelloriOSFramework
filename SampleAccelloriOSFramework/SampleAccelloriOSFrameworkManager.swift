//
//  SampleFrameworkManager.swift
//  SampleFramework
//
//  Created by Admin on 19/11/23.
//

import UIKit

@objc public class SampleAccelloriOSFrameworkManager: NSObject {
    
    @objc public static func instantiateViewController() -> MainViewController? {
        let frameworkBundle = Bundle(for: SampleAccelloriOSFrameworkManager.self)
        let storyboard = UIStoryboard(name: "FrameworkSB", bundle: frameworkBundle)
        return storyboard.instantiateViewController(withIdentifier: "MainViewControllerID") as? MainViewController
    }

}
