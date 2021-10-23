//
//  PicturesViewController.swift
//  TestTask1
//
//  Created by Iuliia Volkova on 19.10.2021.
//

import UIKit

class PicturesViewController: UIViewController {
    
//    private let coordinator: Coordinator
//    
//    init(coordinator: Coordinator) {
//        self.coordinator = coordinator
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
    }
    
    
    private func setupCollectionView(){
        view.addSubview(picturesCollectionView)
        picturesCollectionView.toAutoLayout()
        picturesCollectionView.backgroundColor = UIColor(named: "almostWhite")
        picturesCollectionView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        picturesCollectionView.contentInsetAdjustmentBehavior = .automatic
        
        picturesCollectionView.dataSource = self
        picturesCollectionView.delegate = self
        picturesCollectionView.register(PicturesCollectionCell.self, forCellWithReuseIdentifier: PicturesCollectionCell.reuseID)
        
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
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(addPicToFavs))
        navigationController?.navigationBar.tintColor = UIColor(named: "paleTeal")
    }

    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
    }

}

// MARK: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PicturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionCell.reuseID, for: indexPath) as! PicturesCollectionCell
        let unspashPhoto = pictures[indexPath.item]
        cell.unsplashPhoto = unspashPhoto
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        coordinator.showDetailedViewController(photoId: pictures[indexPath.item].id, profileImageUrl: pictures[indexPath.item].urls.regular)
//        let cell = picturesCollectionView.cellForItem(at: indexPath) as! PicturesCollectionCell
        let detailsVC = PicturesDetailsViewController(pictureID: pictures[indexPath.item].id, pictureURL:  pictures[indexPath.item].urls.regular, pictureAuthor: pictures[indexPath.item].user.name)
        let navController = UINavigationController(rootViewController: detailsVC)
        self.present(navController, animated: true, completion: nil)
    }
        
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = picturesCollectionView.cellForItem(at: indexPath) as! PicturesCollectionViewCell
//        guard let image = cell.pictureImageView.image else { return }
//        selectedImages.append(image)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = picturesCollectionView.cellForItem(at: indexPath) as! PicturesCollectionViewCell
//        guard let image = cell.pictureImageView.image else { return }
//        if let index = selectedImages.firstIndex(of: image) {
//            selectedImages.remove(at: index)
//        }
//    }
}

extension PicturesViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picture = pictures[indexPath.item]
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let widthPerItem = ( view.frame.width - paddingSpace ) / itemsPerRow
        let height = CGFloat(picture.height) * widthPerItem / CGFloat(picture.width)
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

extension PicturesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
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

// MARK: toAutoLayout

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: addSubviews
extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
