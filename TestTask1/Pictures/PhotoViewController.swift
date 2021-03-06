//
//  PicturesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    
    private var pictures = [UnsplashPhoto]()
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var picturesCollectionView = UICollectionView(frame: .zero,
                                                               collectionViewLayout: layout)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRandomPictures()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
    }
    
    private func getRandomPictures(){
        networkDataFetcher.fetchRandomImages { [weak self] randomResults in
            guard let fetchedPhotos = randomResults else { return }
            self?.pictures = fetchedPhotos
            self?.picturesCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView(){
        view.addSubview(picturesCollectionView)
        picturesCollectionView.toAutoLayout()
        picturesCollectionView.backgroundColor = UIColor(named: "almostWhite")
        picturesCollectionView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        picturesCollectionView.contentInsetAdjustmentBehavior = .automatic
        
        picturesCollectionView.dataSource = self
        picturesCollectionView.delegate = self
        picturesCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        
        let constraints = [
            picturesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            picturesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            picturesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picturesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationItem.title = "Pictures"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "pastelSandy")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: "dustyTeal")
    }

    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        let unspashPhoto = pictures[indexPath.item]
        cell.unsplashPhoto = unspashPhoto
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(pictureID: pictures[indexPath.item].id, pictureURL:  pictures[indexPath.item].urls.regular, pictureAuthor: pictures[indexPath.item].user.name)
        let navController = UINavigationController(rootViewController: detailsVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let widthPerItem = ( view.frame.width - paddingSpace ) / itemsPerRow
        let height = widthPerItem
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

}

// MARK: UISearchBarDelegate

extension PhotoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.pictures = fetchedPhotos.results
                self?.picturesCollectionView.reloadData()
            }
        })
    }
}
