//
//  FavoritesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit
import RealmSwift
import SDWebImage

class FavoritesViewController: UIViewController {
    
    private var notificationToken: NotificationToken? = nil
    static let reuseID = "cellID"
    
    private var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "almostWhite")
        tableView.toAutoLayout()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let realmFavsArray = RealmDataBase()
    private var favoritePhotos = [PhotoRealmObject]()

    private var sideInset: CGFloat { return 30 }
    private var rowHeight: CGFloat { return 90 }
    private var headerHeight: CGFloat { return 20 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritePhotos = realmFavsArray.getSavedPhotos()
        favoritesTableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesViewController.reuseID)
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        setupNavigationBar()
        setupViews()
        observeAndUpdate()
    }
    
    // MARK: function to update the array of favorite photos according to changes in realm
    private func observeAndUpdate(){
        lazy var realm = try! Realm()
        let results = realm.objects(PhotoRealmObject.self)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.favoritesTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                self?.favoritePhotos = self?.realmFavsArray.getSavedPhotos() as! [PhotoRealmObject]
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    deinit { notificationToken?.invalidate() }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "pastelSandy")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "dustyTeal")
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "almostWhite")
        view.addSubview(favoritesTableView)
        
        let constraints = [
            favoritesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: sideInset),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesViewController.reuseID) as! FavoritesCell
        cell.backgroundColor = UIColor(named: "almostWhite")
        cell.photo = favoritePhotos[indexPath.item]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(pictureID: favoritePhotos[indexPath.item].id, pictureURL: favoritePhotos[indexPath.item].url, pictureAuthor: favoritePhotos[indexPath.item].author)
        let navController = UINavigationController(rootViewController: detailsVC)
        self.present(navController, animated: true, completion: nil)
        favoritesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
}
