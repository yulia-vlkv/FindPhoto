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
        tabBar.tintColor = UIColor(named: "dustyTeal")
        delegate = self
        setupTabBar()
    }
    
    private func setupTabBar(){
        let photoTab = PicturesViewController()
        photoTab.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 0)
        let favsTab = FavoritesTableViewController()
        favsTab.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart.circle.fill"), tag: 1)
        let photoNavVC = UINavigationController(rootViewController: photoTab)
        let favsNavVC = UINavigationController(rootViewController: favsTab)
        self.viewControllers = [photoNavVC, favsNavVC]
        
    }
}
