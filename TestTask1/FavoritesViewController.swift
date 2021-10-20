//
//  FavoritesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = "cellID"
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
//        NotificationCenter.default.addObserver(self, selector: #selector(goToHabitsVC), name: NSNotification.Name(rawValue: "goToHabitsVC"), object: nil)
        
        setupNavigationBar()
        setupViews()

    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "pastelSandy")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "minus.circle.fill"), style: .plain, target: self, action: #selector(deletePicFromFavs))
        navigationController?.navigationBar.tintColor = UIColor(named: "paleTeal")
    }
    
    @objc func deletePicFromFavs(){
        
    }
    
    private func setupViews() {
        
        view.addSubview(tableView)
        tableView.toAutoLayout()
        
        let constraints = [
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}



//extension FavoritesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
//
//
//}
//
//extension FavoritesViewController: UITableViewDelegate {
//
//
//}
