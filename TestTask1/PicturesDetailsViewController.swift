//
//  PicturesDetailsViewController.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 20.10.2021.
//

import UIKit
import SDWebImage

class PicturesDetailsViewController: UIViewController {
    
    private let networkDataFetcher = NetworkDataFetcher()
    public let realm = RealmDataBase()
    
//    var delegate: ReloadData?
    
//    private let picture: UnsplashPhoto
    private let pictureID: String
    private let pictureURL: String
    private let pictureAuthor: String
    
    private var pictureDetails: PictureDetails? {
        didSet {
            setInfo()
        }
    }
    
    private let picturesArray = RealmDataBase().getSavedPhotos()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.toAutoLayout()
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "almostWhite")
        view.toAutoLayout()
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let imageView: ScaledHeightImageView = {
        let image = ScaledHeightImageView()
        image.backgroundColor = .clear
        image.layer.cornerRadius = 15
        image.toAutoLayout()
        return image
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.toAutoLayout()
        return label
    }()
    
    private let uploadeDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.toAutoLayout()
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.toAutoLayout()
        return label
    }()

    private let downloadCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Downloads: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .clear
        label.toAutoLayout()
        return label
    }()
    
    private var topBottomInset: CGFloat { return 30}
    
    private var sideInset: CGFloat { return 20 }
    
    init(pictureID: String, pictureURL: String, pictureAuthor: String) {
        self.pictureURL = pictureURL
        self.pictureID = pictureID
        self.pictureAuthor = pictureAuthor
        super.init(nibName: nil, bundle: nil)
        networkDataFetcher.fetchDetails(photoID: pictureID) { [weak self] details in
            self?.pictureDetails = details
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        modalPresentationCapturesStatusBarAppearance = true
        self.view.backgroundColor = UIColor(named: "almostWhite")
    
        setupViews()
        setNavigationBar()
    }
    
    private func setNavigationBar(){
//        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.tintColor = UIColor(named: "dustyTeal")
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "pastelSandy")
        self.navigationItem.title = "Details"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        
        if picturesArray.contains( where: { $0.id == pictureID } ) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(showAlert))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
        }
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveImage() {
        realm.savePhoto(id: pictureID, url: pictureURL, author: pictureAuthor)
        cancel()
//        guard delegate != nil else { return }
//        delegate!.reloadData()
    }
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Delete Image", message: "You Sure?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let confirm = UIAlertAction(title: "Delete", style: .default) { (action: UIAlertAction) in
            self.deleteImage()
        }

//        let confirm = UIAlertAction(title: "Удалить", style: .default) { (action:UIAlertAction) in
//            HabitsStore.shared.habits.removeAll{$0 == self.habit}
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToHabitsVC"), object: nil)
//            self.dismiss(animated: true, completion: {
//                let mainHabbitVC = HabitViewController ()
//                self.present(mainHabbitVC, animated: true, completion: nil)
//            })
//        }
        alertController.addAction(cancel)
        alertController.addAction(confirm)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func deleteImage() {
//        guard delegate != nil else { return }
        realm.deletePhoto(id: pictureID)
//        delegate!.reloadData()
        cancel()
    }
    
    private func setInfo() {
        
        guard let picture = pictureDetails else { return }
        
        imageView.sd_setImage(with: URL(string: picture.urls.regular), completed: nil)
        
        updateLabels(lable: authorLabel, text: authorLabel.text!, data: picture.user.name)
        
        let dateGet = DateFormatter()
        dateGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let datePrint = DateFormatter()
        datePrint.dateFormat = "MMM d, yyyy"
        if let date = dateGet.date(from: picture.created_at){
            let finalDate = datePrint.string(from: date)
            updateLabels(lable: uploadeDateLabel, text: uploadeDateLabel.text!, data: finalDate)
        } else {
            print("An error while decoding the date string")
        }
        
        updateLabels(lable: downloadCountLabel, text: downloadCountLabel.text!, data: String(picture.downloads))
        
        if picture.location.city != nil && picture.location.country != nil {
            updateLabels(lable: locationLabel, text: locationLabel.text!, data: "\(picture.location.city!), \(picture.location.country!)")
        } else if picture.location.city != nil {
            updateLabels(lable: locationLabel, text: locationLabel.text!, data: "\(picture.location.city!)")
        } else if picture.location.country != nil {
                updateLabels(lable: locationLabel, text: locationLabel.text!, data: "\(picture.location.country!)")
        } else {
            updateLabels(lable: locationLabel, text: locationLabel.text!, data: " - ")
        }
    }
        
    func updateLabels(lable: UILabel, text: String, data: String) {
        let fontA = UIFont.systemFont(ofSize: 20, weight: .regular)
        let attributesA = [NSAttributedString.Key.font: fontA]
        let textStr = NSMutableAttributedString(string: text, attributes: attributesA)
        let fontB = UIFont.systemFont(ofSize: 20, weight: .light)
        let attributesB = [NSAttributedString.Key.font: fontB]
        let dataStr = NSMutableAttributedString(string: data, attributes: attributesB)
        textStr.append(dataStr)
        lable.attributedText = textStr
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(uploadeDateLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(downloadCountLabel)

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomInset),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset)
        ]

        NSLayoutConstraint.activate(constraints)

    }
    
}


class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
