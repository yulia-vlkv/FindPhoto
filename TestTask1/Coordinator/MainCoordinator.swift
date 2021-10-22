//
//  MainCoordinator.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 22.10.2021.
//

//import Foundation
//import UIKit
//
//class MainCoordinator {
//
//    private let mainTabBarController: UITabBarController
//    var delegate: ReloadData?
//
//    init(mainTabBarController: UITabBarController) {
//        self.mainTabBarController = mainTabBarController
//    }
//
//    func start() {
//        let searchNavigationController = UINavigationController()
//        searchNavigationController.tabBarItem.title = "Search"
//        searchNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
//
//
//        let favouritesNavigationController = UINavigationController()
//        favouritesNavigationController.tabBarItem.title = "Favourites"
//        favouritesNavigationController.tabBarItem.image = UIImage(systemName: "heart.circle.fill")
//
//        mainTabBarController.viewControllers = [searchNavigationController, favouritesNavigationController]
//    }
//
//
//}
//
//
//protocol ReloadData {
//    func reloadData() -> Void
//}
//
//
//import UIKit
//
//// MARK: - Coordinator Protocol
//protocol Coordinator {
//    func showDetailedViewController(photoId: String, profileImageUrl: String) -> Void
//}
//
//// MARK: - ReloadData Protocol
//protocol ReloadData {
//    func reloadData() -> Void
//}
//
//// MARK: - MainCoordinator
//class MainCoordinator {
//
//    private let tabBarController: UITabBarController
//    var delegate: ReloadData?
//
//    init(tabBarController: UITabBarController) {
//        self.tabBarController = tabBarController
//    }
//
//    func start() {
//        let photosNavigationController = UINavigationController()
//        let favoritesNavigationController = UINavigationController()
//
//        photosNavigationController.tabBarItem.title = "Photos"
//        photosNavigationController.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.angled")
//
//        favoritesNavigationController.tabBarItem.title = "Favourites"
//        favoritesNavigationController.tabBarItem.image = UIImage(systemName: "heart.fill")
//
//        tabBarController.viewControllers = [
//            photosNavigationController,
//            favoritesNavigationController
//        ]
//
//        let photosCoordinator = ChildCoordinator(navigationController: photosNavigationController)
//        let favoritesCoordinator = ChildCoordinator(navigationController: favoritesNavigationController)
//        let photosViewController = PicturesViewController(coordinator: photosCoordinator)
//        let favoritesViewController = FavoritesTableViewController(coordinator: favoritesCoordinator)
//
//        photosNavigationController.viewControllers = [photosViewController]
//        favoritesNavigationController.viewControllers = [favoritesViewController]
//
//        favoritesCoordinator.delegate = favoritesViewController
//    }
//}
