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
    var countryCodeLabelTopAnchor: NSLayoutConstraint?
    
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
        view.backgroundColor = .clear
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
        label.text = "Description:"
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
        textView.backgroundColor = ColorConstant.fourthColor
        
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
    
    let vcaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "vca"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(moreInfoAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let vetstreetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "vetstreet"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(moreInfoAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let cfaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cfa"), for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(moreInfoAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let wikiButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "wiki"), for: .normal)
        button.tag = 3
        button.addTarget(self, action: #selector(moreInfoAction(_:)), for: .touchUpInside)
        return button
    }()
    
    let allPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View all photo", for: .normal)
        button.backgroundColor = ColorConstant.thirdColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(showBreedImageGallery), for: .touchUpInside)
        return button
    }()
    
    let characteristicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Characteristics:"
        return label
    }()
    
    let altNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Alt Name: "
        return label
    }()
    
    let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Country Code: "
        return label
    }()
    
    let originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Origin: "
        return label
    }()
    
    let temperamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Temperament: "
        return label
    }()
    
    let lifeSpanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Life Span: "
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Weight(metric): "
        return label
    }()
    
    let experimentalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Experimental: "
        return label
    }()
    
    let hairlessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Hairless: "
        return label
    }()
    
    let rareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Rare: "
        return label
    }()
    
    let rexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Rex: "
        return label
    }()
    
    let suppressTailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Suppress tail: "
        return label
    }()
    
    let shortLegsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "ShortLegs: "
        return label
    }()
    
    let hypoallergenicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Hypoallergenic: "
        return label
    }()
    
    let naturalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Natural: "
        return label
    }()
    
    let adaptabilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Adaptability: "
        return label
    }()
    
    let adaptabilityRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let affectionLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Affection Level: "
        return label
    }()
    
    let affectionLevelRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let childFriendlyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Child Friendly: "
        return label
    }()
    
    let childFriendlyRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let dogFriendlyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Dog Friendly: "
        return label
    }()
    
    let dogFriendlyRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let energyLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Energy Level: "
        return label
    }()
    
    let energyLevelRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let groomingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Grooming: "
        return label
    }()
    
    let groomingRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let healthIssuesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Health Issues: "
        return label
    }()
    
    let healthIssuesRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let intelligenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Intelligence: "
        return label
    }()
    
    let intelligenceRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let sheddingLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Shedding Level: "
        return label
    }()
    
    let sheddingLevelRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let socialNeedsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Social Needs: "
        return label
    }()
    
    let socialNeedsRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let strangerFriendlyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Stranger Friendly: "
        return label
    }()
    
    let strangerFriendlyRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    let vocalisationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Vocalisation: "
        return label
    }()
    
    let vocalisationRating: RatingControl = {
        let ratingControl = RatingControl()
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        return ratingControl
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = ColorConstant.thirdColor
        view.backgroundColor = ColorConstant.fourthColor
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
        
        let font = UIFont.systemFont(ofSize: 14)
        
        if breed.altNames == "" || breed.altNames == nil {
            altNameLabel.isHidden = true
            countryCodeLabelTopAnchor?.constant = -20
        } else {
            altNameLabel.text = altNameLabel.text! + breed.altNames!
            altNameLabel.attributedText = attributedText(withBoldString: altNameLabel.text, string: breed.altNames!, font: font)
        }
        
        countryCodeLabel.text? += breed.countryCode
        countryCodeLabel.attributedText = attributedText(withBoldString: countryCodeLabel.text, string: breed.countryCode, font: font)
        originLabel.text? += breed.origin
        originLabel.attributedText = attributedText(withBoldString: originLabel.text, string: breed.origin, font: font)
        temperamentLabel.text? += breed.temperament
        temperamentLabel.attributedText = attributedText(withBoldString: temperamentLabel.text, string: breed.temperament, font: font)
        lifeSpanLabel.text? += breed.lifeSpan
        lifeSpanLabel.attributedText = attributedText(withBoldString: lifeSpanLabel.text, string: breed.lifeSpan, font: font)
        weightLabel.text? += breed.weight.metric
        weightLabel.attributedText = attributedText(withBoldString: weightLabel.text, string: breed.weight.metric, font: font)
        experimentalLabel.text? += breed.experimental.isBool
        experimentalLabel.attributedText = attributedText(withBoldString: experimentalLabel.text, string: breed.experimental.isBool, font: font)
        hairlessLabel.text? += breed.hairless.isBool
        hairlessLabel.attributedText = attributedText(withBoldString: hairlessLabel.text, string: breed.hairless.isBool, font: font)
        naturalLabel.text? += breed.natural.isBool
        naturalLabel.attributedText = attributedText(withBoldString: naturalLabel.text, string: breed.natural.isBool, font: font)
        rareLabel.text? += breed.rare.isBool
        rareLabel.attributedText = attributedText(withBoldString: rareLabel.text, string: breed.rare.isBool, font: font)
        rexLabel.text? += breed.rex.isBool
        rexLabel.attributedText = attributedText(withBoldString: rexLabel.text, string: breed.rex.isBool, font: font)
        suppressTailLabel.text? += breed.suppressedTail.isBool
        suppressTailLabel.attributedText = attributedText(withBoldString: suppressTailLabel.text, string: breed.suppressedTail.isBool, font: font)
        shortLegsLabel.text? += breed.shortLegs.isBool
        shortLegsLabel.attributedText = attributedText(withBoldString: shortLegsLabel.text, string: breed.shortLegs.isBool, font: font)
        hypoallergenicLabel.text? += breed.hypoallergenic.isBool
        hypoallergenicLabel.attributedText = attributedText(withBoldString: hypoallergenicLabel.text, string: breed.hypoallergenic.isBool, font: font)
        
        adaptabilityRating.rating = breed.adaptability
        affectionLevelRating.rating = breed.affectionLevel
        childFriendlyRating.rating = breed.childFriendly
        dogFriendlyRating.rating = breed.dogFriendly
        energyLevelRating.rating = breed.energyLevel
        groomingRating.rating = breed.grooming
        healthIssuesRating.rating = breed.healthIssues
        intelligenceRating.rating = breed.intelligence
        sheddingLevelRating.rating = breed.sheddingLevel
        socialNeedsRating.rating = breed.socialNeeds
        strangerFriendlyRating.rating = breed.strangerFriendly
        vocalisationRating.rating = breed.vocalisation
        
    }
    
    @objc func showBreedImageGallery() {
        let vc = GalleryViewController(forBreed: true)
        vc.set(breed: curentBreed)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moreInfoAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if (curentBreed.vcahospitalsUrl != nil) {
                guard let url = URL(string: curentBreed.vcahospitalsUrl!) else { return }
                UIApplication.shared.open(url, options: [:])
            } else {
                ErrorPresenter.showError(message: "URL not found", on: self)
            }
        case 1:
            if (curentBreed.vetstreetUrl != nil) {
                guard let url = URL(string: curentBreed.vetstreetUrl!) else { return }
                UIApplication.shared.open(url, options: [:])
            } else {
                ErrorPresenter.showError(message: "URL not found", on: self)
            }
        case 2:
            if (curentBreed.cfaUrl != nil) {
                guard let url = URL(string: curentBreed.cfaUrl!) else { return }
                UIApplication.shared.open(url, options: [:])
            } else {
                ErrorPresenter.showError(message: "URL not found", on: self)
            }
        case 3:
            if (curentBreed.wikipediaUrl != nil) {
                guard let url = URL(string: curentBreed.wikipediaUrl!) else { return }
                UIApplication.shared.open(url, options: [:])
            } else {
                ErrorPresenter.showError(message: "URL not found", on: self)
            }
        default:
            return
        }
    }
}

extension BreedDetailViewController {
    func setImageViewHeight(image: BreedImageResponse) {
        let photoHeight: Float = Float(image.height)
        let photoWidth: Float = Float(image.width)
        let ratio = CGFloat(photoHeight / photoWidth)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let newPhotoHeight = screenWidth * ratio
        imageViewHeightConstraint?.constant = CGFloat(newPhotoHeight)
    }
    
    func attributedText(withBoldString: String?, string: String, font: UIFont) -> NSAttributedString {
        guard let boldString = withBoldString else { return NSAttributedString()}
        let boltAttributedString = NSMutableAttributedString(string: boldString,
                                                             attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)])
        let fontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let range = (boldString as NSString).range(of: string)
        boltAttributedString.addAttributes(fontAttribute, range: range)
        return boltAttributedString
    }
}

extension BreedDetailViewController {
    //MARK: - Constraints
    func overlayFirstLayer() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(cardView)
        
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
        cardView.addSubview(allPhotoButton)
        cardView.addSubview(characteristicsLabel)
        cardView.addSubview(altNameLabel)
        cardView.addSubview(countryCodeLabel)
        cardView.addSubview(originLabel)
        cardView.addSubview(temperamentLabel)
        cardView.addSubview(lifeSpanLabel)
        cardView.addSubview(weightLabel)
        cardView.addSubview(experimentalLabel)
        cardView.addSubview(hairlessLabel)
        cardView.addSubview(naturalLabel)
        cardView.addSubview(rareLabel)
        cardView.addSubview(rexLabel)
        cardView.addSubview(suppressTailLabel)
        cardView.addSubview(shortLegsLabel)
        cardView.addSubview(hypoallergenicLabel)
        cardView.addSubview(adaptabilityLabel)
        cardView.addSubview(adaptabilityRating)
        cardView.addSubview(affectionLevelLabel)
        cardView.addSubview(affectionLevelRating)
        cardView.addSubview(childFriendlyLabel)
        cardView.addSubview(childFriendlyRating)
        cardView.addSubview(dogFriendlyLabel)
        cardView.addSubview(dogFriendlyRating)
        cardView.addSubview(energyLevelLabel)
        cardView.addSubview(energyLevelRating)
        cardView.addSubview(groomingLabel)
        cardView.addSubview(groomingRating)
        cardView.addSubview(healthIssuesLabel)
        cardView.addSubview(healthIssuesRating)
        cardView.addSubview(intelligenceLabel)
        cardView.addSubview(intelligenceRating)
        cardView.addSubview(sheddingLevelLabel)
        cardView.addSubview(sheddingLevelRating)
        cardView.addSubview(socialNeedsLabel)
        cardView.addSubview(socialNeedsRating)
        cardView.addSubview(strangerFriendlyLabel)
        cardView.addSubview(strangerFriendlyRating)
        cardView.addSubview(vocalisationLabel)
        cardView.addSubview(vocalisationRating)
        
        //MARK: - imageView constraints
        imageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 100)
        imageViewHeightConstraint?.isActive = true
        
        //MARK: - descriptionTitleLabel constraints
        descriptionTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor ,constant: 10).isActive = true
        descriptionTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
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
        
        //MARK: - allPhotoButton constraints
        allPhotoButton.topAnchor.constraint(equalTo: socialView.bottomAnchor, constant: 20).isActive = true
        allPhotoButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 40).isActive = true
        allPhotoButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -40).isActive = true
        allPhotoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //MARK: - characteristicsLabel constraints
        characteristicsLabel.topAnchor.constraint(equalTo: allPhotoButton.bottomAnchor ,constant: 20).isActive = true
        characteristicsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        characteristicsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - altNameLabel constraints
        altNameLabel.topAnchor.constraint(equalTo: characteristicsLabel.bottomAnchor ,constant: 10).isActive = true
        altNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        altNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - countryCodeLabel constraints
        countryCodeLabelTopAnchor = countryCodeLabel.topAnchor.constraint(equalTo: altNameLabel.bottomAnchor ,constant: 10)
        countryCodeLabelTopAnchor?.isActive = true
        countryCodeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        countryCodeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - originLabel constraints
        originLabel.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor ,constant: 10).isActive = true
        originLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        originLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - temperamentLabel constraints
        temperamentLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor ,constant: 10).isActive = true
        temperamentLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        temperamentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - lifeSpanLabel constraints
        lifeSpanLabel.topAnchor.constraint(equalTo: temperamentLabel.bottomAnchor ,constant: 10).isActive = true
        lifeSpanLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        lifeSpanLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - weightLabel constraints
        weightLabel.topAnchor.constraint(equalTo: lifeSpanLabel.bottomAnchor ,constant: 10).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        weightLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - experimentalLabel constraints
        experimentalLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor ,constant: 10).isActive = true
        experimentalLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        experimentalLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - hairlessLabel constraints
        hairlessLabel.topAnchor.constraint(equalTo: experimentalLabel.bottomAnchor ,constant: 10).isActive = true
        hairlessLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        hairlessLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - naturalLabel constraints
        naturalLabel.topAnchor.constraint(equalTo: hairlessLabel.bottomAnchor ,constant: 10).isActive = true
        naturalLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        naturalLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - rareLabel constraints
        rareLabel.topAnchor.constraint(equalTo: naturalLabel.bottomAnchor ,constant: 10).isActive = true
        rareLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        rareLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - rexLabel constraints
        rexLabel.topAnchor.constraint(equalTo: rareLabel.bottomAnchor ,constant: 10).isActive = true
        rexLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        rexLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - suppressTailLabel constraints
        suppressTailLabel.topAnchor.constraint(equalTo: rexLabel.bottomAnchor ,constant: 10).isActive = true
        suppressTailLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        suppressTailLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - shortLegsLabel constraints
        shortLegsLabel.topAnchor.constraint(equalTo: suppressTailLabel.bottomAnchor ,constant: 10).isActive = true
        shortLegsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        shortLegsLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - hypoallergenicLabel constraints
        hypoallergenicLabel.topAnchor.constraint(equalTo: shortLegsLabel.bottomAnchor ,constant: 10).isActive = true
        hypoallergenicLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        hypoallergenicLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        
        //MARK: - adaptabilityLabel constraints
        adaptabilityLabel.topAnchor.constraint(equalTo: hypoallergenicLabel.bottomAnchor ,constant: 10).isActive = true
        adaptabilityLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - adaptabilityRating constraints
        adaptabilityRating.centerYAnchor.constraint(equalTo: adaptabilityLabel.centerYAnchor).isActive = true
        adaptabilityRating.leadingAnchor.constraint(equalTo: adaptabilityLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - affectionLevelLabel constraints
        affectionLevelLabel.topAnchor.constraint(equalTo: adaptabilityLabel.bottomAnchor ,constant: 10).isActive = true
        affectionLevelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - adaptabilityRating constraints
        affectionLevelRating.centerYAnchor.constraint(equalTo: affectionLevelLabel.centerYAnchor).isActive = true
        affectionLevelRating.leadingAnchor.constraint(equalTo: affectionLevelLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - childFriendlyLabel constraints
        childFriendlyLabel.topAnchor.constraint(equalTo: affectionLevelRating.bottomAnchor ,constant: 10).isActive = true
        childFriendlyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - childFriendlyRating constraints
        childFriendlyRating.centerYAnchor.constraint(equalTo: childFriendlyLabel.centerYAnchor).isActive = true
        childFriendlyRating.leadingAnchor.constraint(equalTo: childFriendlyLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - dogFriendlyLabel constraints
        dogFriendlyLabel.topAnchor.constraint(equalTo: childFriendlyLabel.bottomAnchor ,constant: 10).isActive = true
        dogFriendlyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - dogFriendlyRating constraints
        dogFriendlyRating.centerYAnchor.constraint(equalTo: dogFriendlyLabel.centerYAnchor).isActive = true
        dogFriendlyRating.leadingAnchor.constraint(equalTo: dogFriendlyLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - energyLevelLabel constraints
        energyLevelLabel.topAnchor.constraint(equalTo: dogFriendlyLabel.bottomAnchor ,constant: 10).isActive = true
        energyLevelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - energyLevelRating constraints
        energyLevelRating.centerYAnchor.constraint(equalTo: energyLevelLabel.centerYAnchor).isActive = true
        energyLevelRating.leadingAnchor.constraint(equalTo: energyLevelLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - groomingLabel constraints
        groomingLabel.topAnchor.constraint(equalTo: energyLevelLabel.bottomAnchor ,constant: 10).isActive = true
        groomingLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - groomingRating constraints
        groomingRating.centerYAnchor.constraint(equalTo: groomingLabel.centerYAnchor).isActive = true
        groomingRating.leadingAnchor.constraint(equalTo: groomingLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - healthIssuesLabel constraints
        healthIssuesLabel.topAnchor.constraint(equalTo: groomingLabel.bottomAnchor ,constant: 10).isActive = true
        healthIssuesLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - adaptabilityRating constraints
        healthIssuesRating.centerYAnchor.constraint(equalTo: healthIssuesLabel.centerYAnchor).isActive = true
        healthIssuesRating.leadingAnchor.constraint(equalTo: healthIssuesLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - intelligenceLabel constraints
        intelligenceLabel.topAnchor.constraint(equalTo: healthIssuesLabel.bottomAnchor ,constant: 10).isActive = true
        intelligenceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - intelligenceRating constraints
        intelligenceRating.centerYAnchor.constraint(equalTo: intelligenceLabel.centerYAnchor).isActive = true
        intelligenceRating.leadingAnchor.constraint(equalTo: intelligenceLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - sheddingLevelLabel constraints
        sheddingLevelLabel.topAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor ,constant: 10).isActive = true
        sheddingLevelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - sheddingLevelRating constraints
        sheddingLevelRating.centerYAnchor.constraint(equalTo: sheddingLevelLabel.centerYAnchor).isActive = true
        sheddingLevelRating.leadingAnchor.constraint(equalTo: sheddingLevelLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - socialNeedsLabel constraints
        socialNeedsLabel.topAnchor.constraint(equalTo: sheddingLevelLabel.bottomAnchor ,constant: 10).isActive = true
        socialNeedsLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - socialNeedsRating constraints
        socialNeedsRating.centerYAnchor.constraint(equalTo: socialNeedsLabel.centerYAnchor).isActive = true
        socialNeedsRating.leadingAnchor.constraint(equalTo: socialNeedsLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - strangerFriendlyLabel constraints
        strangerFriendlyLabel.topAnchor.constraint(equalTo: socialNeedsLabel.bottomAnchor ,constant: 10).isActive = true
        strangerFriendlyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        
        //MARK: - strangerFriendlyRating constraints
        strangerFriendlyRating.centerYAnchor.constraint(equalTo: strangerFriendlyLabel.centerYAnchor).isActive = true
        strangerFriendlyRating.leadingAnchor.constraint(equalTo: strangerFriendlyLabel.trailingAnchor, constant: 20).isActive = true
        
        //MARK: - vocalisationLabel constraints
        vocalisationLabel.topAnchor.constraint(equalTo: strangerFriendlyLabel.bottomAnchor ,constant: 10).isActive = true
        vocalisationLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        vocalisationLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
        //MARK: - vocalisationRating constraints
        vocalisationRating.centerYAnchor.constraint(equalTo: vocalisationLabel.centerYAnchor).isActive = true
        vocalisationRating.leadingAnchor.constraint(equalTo: vocalisationLabel.trailingAnchor, constant: 20).isActive = true
        
    }
    
    func overleyThirdLayerOnSocialView() {
        socialView.addSubview(vcaButton)
        socialView.addSubview(vetstreetButton)
        socialView.addSubview(cfaButton)
        socialView.addSubview(wikiButton)
        
        //MARK: - vcaImageView constraints
        vcaButton.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        vcaButton.leadingAnchor.constraint(equalTo: socialView.leadingAnchor).isActive = true
        vcaButton.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        vcaButton.widthAnchor.constraint(equalTo: socialView.heightAnchor, multiplier: 1.5).isActive = true
        
        //MARK: - vetstreetImageView constraints
        vetstreetButton.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        vetstreetButton.leadingAnchor.constraint(equalTo: vcaButton.trailingAnchor, constant: 30).isActive = true
        vetstreetButton.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        vetstreetButton.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
        //MARK: - cfaImageView constraints
        cfaButton.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        cfaButton.leadingAnchor.constraint(equalTo: vetstreetButton.trailingAnchor, constant: 30).isActive = true
        cfaButton.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        cfaButton.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
        //MARK: - wikiImageView constraints
        wikiButton.topAnchor.constraint(equalTo: socialView.topAnchor).isActive = true
        wikiButton.leadingAnchor.constraint(equalTo: cfaButton.trailingAnchor, constant: 30).isActive = true
        wikiButton.bottomAnchor.constraint(equalTo: socialView.bottomAnchor).isActive = true
        wikiButton.widthAnchor.constraint(equalTo: socialView.heightAnchor).isActive = true
        
    }
}
