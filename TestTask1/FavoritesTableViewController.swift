//
//  FavoritesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit
import RealmSwift
import SDWebImage

class FavoritesTableViewController: UIViewController {
    
    private var notificationToken: NotificationToken? = nil
    
//    private let coordinator: Coordinator
//
//    init(coordinator: Coordinator) {
//        self.coordinator = coordinator
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let reuseID = "cellID"
    
    private var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "almostWhite")
        tableView.toAutoLayout()
        return tableView
    }()
    
    private let myrealm = RealmDataBase()
    private var favoritePhotos = [PhotoRealmObject]()

    
    private var sideInset: CGFloat { return 30 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritePhotos = myrealm.getSavedPhotos()
        
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewController.reuseID)
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        setupNavigationBar()
        setupViews()
        observeAndUpdate()

    }
    
    private func observeAndUpdate(){
        let realm = try! Realm()
        let results = realm.objects(PhotoRealmObject.self)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.favoritesTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                       // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                       // Always apply updates in the following order: deletions, insertions, then modifications.
                       // Handling insertions before deletions may result in unexpected behavior.
                self?.favoritePhotos = (self?.myrealm.getSavedPhotos())!
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                            with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                            with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                            with: .automatic)
                tableView.endUpdates()
                       
            case .error(let error):
                       // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                   }
               }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritesTableView.reloadData()
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
//        coordinator.showDetailedViewController(photoId: favoritePhotos[indexPath.item].id, profileImageUrl: favoritePhotos[indexPath.item].url)
        let detailsVC = PicturesDetailsViewController(pictureID: favoritePhotos[indexPath.item].id, pictureURL: favoritePhotos[indexPath.item].url, pictureAuthor: favoritePhotos[indexPath.item].author)
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

//extension FavoritesTableViewController: ReloadData {
//    func reloadData() {
//        favoritesTableView.reloadData()
//    }
//}
