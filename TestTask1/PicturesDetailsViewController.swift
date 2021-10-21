//
//  PicturesDetailsViewController.swift
//  FindPhotos
//
//  Created by Iuliia Volkova on 20.10.2021.
//

import UIKit

class PicturesDetailsViewController: UIViewController {
    
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
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 15
        image.toAutoLayout()
        return image
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .lightGray
        label.toAutoLayout()
        return label
    }()
    
    private let uploadeDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .lightGray
        label.toAutoLayout()
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .lightGray
        label.toAutoLayout()
        return label
    }()

    private let downloadCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Downloads: "
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .lightGray
        label.toAutoLayout()
        return label
    }()
    
    private var topBottomInset: CGFloat { return 30}
    
    private var sideInset: CGFloat { return 20 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "almostWhite")
    
        setupViews()
        setNavigationBar()

    }
    
    private func setNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor(named: "paleTeal")
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "pastelSandy")
        self.navigationItem.title = "Details"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func save() {
        cancel()
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
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topBottomInset),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInset)
        ]

        NSLayoutConstraint.activate(constraints)

    }
    
}
