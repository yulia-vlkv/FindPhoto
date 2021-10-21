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
    
    private var sideInset: CGFloat { return 30 }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
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
        
        view.backgroundColor = UIColor(named: "almostWhite")
        tableView.backgroundColor = UIColor(named: "almostWhite")
        
        view.addSubview(tableView)
        tableView.toAutoLayout()
        
        let constraints = [
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}



extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // всегда одно
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "star")
        content.text = "Author: "
        cell.contentConfiguration = content
        cell.backgroundColor = UIColor(named: "pastelSandy")
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.clear.cgColor
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // = количество сохраненных фото
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
//        let detailsVC = PicturesDetailsViewController(cell.unsplashPhoto)
//        let navController = UINavigationController(rootViewController: detailsVC)
//        self.present(navController, animated: true, completion: nil)
    }

}
