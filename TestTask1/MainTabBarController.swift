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
    
        setupTabBar()
    }

    private func setupTabBar(){
        let searchTab = PicturesViewController()
        searchTab.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 0)
        let searchTabVC = UINavigationController(rootViewController: searchTab)
        
        let favsTab = FavoritesViewController()
        favsTab.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.circle.fill"), tag: 1)
        let favsTabVC = UINavigationController(rootViewController: favsTab)
        
        self.viewControllers = [searchTabVC, favsTabVC]
    }

}

