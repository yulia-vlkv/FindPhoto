//
//  FavoritesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit
import SDWebImage

class FavoritesTableViewController: UIViewController {
    
    static let reuseID = "cellID"
    
    private let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "almostWhite")
        tableView.toAutoLayout()
        return tableView
    }()
    
    private let realm = RealmDataBase()
    private var favoritePhotos = [PhotoRealmObject]()
    
    private var sideInset: CGFloat { return 30 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritePhotos = realm.getSavedPhotos()

        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewController.reuseID)
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        setupNavigationBar()
        setupViews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritesTableView.reloadData()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "pastelSandy")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "paleTeal")
    }
    
    
    private func setupViews() {
        
        view.backgroundColor = UIColor(named: "almostWhite")

        view.addSubview(favoritesTableView)
        
        let constraints = [
            
            favoritesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}



extension FavoritesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewController.reuseID) as! FavoritesTableViewCell
        cell.photo = favoritePhotos[indexPath.item]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! FavoritesTableViewCell

//        cell.backgroundColor = UIColor(named: "pastelSandy")
//        cell.clipsToBounds = true
//        cell.layer.cornerRadius = 15
//        cell.layer.borderColor = UIColor.clear.cgColor
        
//        cell.photo = favoritePhotos[indexPath.item]
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = PicturesDetailsViewController(pictureID: favoritePhotos[indexPath.item].id, pictureURL: favoritePhotos[indexPath.item].url)
        let navController = UINavigationController(rootViewController: detailsVC)
        self.present(navController, animated: true, completion: nil)
        favoritesTableView.reloadData()
        
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        favoritesTableView.reloadData()
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return favoritePhotos.count
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}
