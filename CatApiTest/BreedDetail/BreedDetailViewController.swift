//
//  BreedDetailViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 14.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {

    var curentBreed: BreedResponse!
    let fetcher = NetworkDataFetcher()

    var imageViewHeightConstraint: NSLayoutConstraint?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isDirectionalLockEnabled = true
        view.alwaysBounceVertical = true
        view.contentSize = CGSize(width: 200, height: 1200)
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Description"
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return textView
    }()
    
    let moreInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "More info:"
        return label
    }()
    
    let socialView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vcaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "vca")
        return imageView
    }()
    
    let vetstreetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "vetstreet")
        return imageView
    }()
    
    let cfaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cfa")
        return imageView
    }()
    
    let wikiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "wiki")
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = curentBreed.name
        overlayFirstLayer()
        overlaySecondLayer()
        overleyThirdLayerOnSocialView()
        set()
    }
    

    func set() {
        guard let breed = curentBreed else { return }
        fetcher.getImageUrl(breed) { (breedImageResponse) in
            guard let image = breedImageResponse?.first else { return }
            self.imageView.set(imageURL: image.url)
            self.setImageViewHeight(image: image)
        }
        
        descriptionTextView.text = breed.description
    }
    func overlayFirstLayer() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(cardView)
        
        //MARK: - cardView constraints
        cardView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 1900).isActive = true
    }
    
    func overlaySecondLayer() {
        cardView.addSubview(imageView)
        cardView.addSubview(descriptionTitleLabel)
        cardView.addSubview(descriptionTextView)
        cardView.addSubview(moreInfoLabel)
        cardView.addSubview(socialView)
        
        //MARK: - imageView constraints
        imageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
        imageViewHeightConstraint?.isActive = true
        
        //MARK: - descriptionTitleLabel constraints
        descriptionTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor ,constant: 10).isActive = true
        descriptionTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        descriptionTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - descriptionTextView constraints
        descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - moreInfoLabel constraints
        moreInfoLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10).isActive = true
        moreInfoLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        moreInfoLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        moreInfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //MARK: - socialView constraints
        socialView.topAnchor.constraint(equalTo: moreInfoLabel.bottomAnchor, constant: 10).isActive = true
        socialView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        socialView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        socialView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func overleyThirdLayerOnSocialView() {
        socialView.addSubview(vcaImageView)
        socialView.addSubview(vetstreetImageView)
        socialView.addSubview(cfaImageView)
        socialView.addSubview(wikiImageView)
        
        //MARK: - vcaImageView constraints
        vcaImageView.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        vcaImageView.leadingAnchor.constraint(equalTo: socialView.leadingAnchor).isActive = true
        vcaImageView.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        vcaImageView.widthAnchor.constraint(equalTo: socialView.heightAnchor, multiplier: 1.5).isActive = true
        
        //MARK: - vetstreetImageView constraints
        vetstreetImageView.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        vetstreetImageView.leadingAnchor.constraint(equalTo: vcaImageView.trailingAnchor, constant: 20).isActive = true
        vetstreetImageView.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        vetstreetImageView.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
        //MARK: - cfaImageView constraints
        cfaImageView.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        cfaImageView.leadingAnchor.constraint(equalTo: vetstreetImageView.trailingAnchor, constant: 20).isActive = true
        cfaImageView.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        cfaImageView.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
        //MARK: - wikiImageView constraints
        wikiImageView.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        wikiImageView.leadingAnchor.constraint(equalTo: cfaImageView.trailingAnchor, constant: 20).isActive = true
        wikiImageView.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        wikiImageView.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
    }

    func setImageViewHeight(image: BreedImageResponse) {
        let photoHeight: Float = Float(image.height)
        let photoWidth: Float = Float(image.width)
        let ratio = CGFloat(photoHeight / photoWidth)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let newPhotoHeight = screenWidth * ratio
        imageViewHeightConstraint?.constant = CGFloat(newPhotoHeight)
    }
}

