//
//  MainCoordinator.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

import Foundation
import UIKit

class MainCoordinator {
    
    private let mainTabBarController: UITabBarController
    
    init(mainTabBarController: UITabBarController) {
        self.mainTabBarController = mainTabBarController
    }
    
    func start() {
        let photosNavigationController = UINavigationController()
        photosNavigationController.tabBarItem.title = "Search"
        photosNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
                                                              
        
        let favouritesNavigationController = UINavigationController()
        favouritesNavigationController.tabBarItem.title = "Favourites"
        favouritesNavigationController.tabBarItem.image = UIImage(systemName: "heart.circle.fill")
        
        mainTabBarController.viewControllers = [photosNavigationController, favouritesNavigationController]
    }
    


}

