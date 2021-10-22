//
//  MainTabBar.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = UIColor(named: "pastelSandy")
        tabBar.tintColor = UIColor(named: "paleTeal")
        delegate = self
    }
}

