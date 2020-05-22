//
//  BreedCell.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import UIKit

final class BreedCell: UITableViewCell {
    static let reuseId = "BreedCell"
    
    //First layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorConstant.thirdColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    //Second layer
    let breedNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cat")
        return imageView
    }()
    
    let originNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let originImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "origin")
        return imageView
    }()
    
    override func prepareForReuse() {
        breedNameLabel.text = nil
        originNameLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    func set(breed: BreedResponse) {
        breedNameLabel.text = breed.name
        originNameLabel.text = breed.origin
    }
    private func overlaySecondLayer() {
        cardView.addSubview(breedNameLabel)
        cardView.addSubview(catImageView)
        cardView.addSubview(originNameLabel)
        cardView.addSubview(originImageView)
        
        //catImageView constraints
        catImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5).isActive = true
        catImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        catImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        catImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //breedNameLabel constraints
        breedNameLabel.topAnchor.constraint(equalTo: catImageView.topAnchor).isActive = true
        breedNameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 5).isActive = true
        breedNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        breedNameLabel.heightAnchor.constraint(equalTo: catImageView.heightAnchor).isActive = true
        
        //originImageView constraints
        originImageView.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 5).isActive = true
        originImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        originImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5).isActive = true
        originImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        originImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //originNameLabel constraints
        originNameLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor, constant: 5).isActive = true
        originNameLabel.leadingAnchor.constraint(equalTo: originImageView.trailingAnchor, constant: 5).isActive = true
        originNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        originNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5).isActive = true
        originNameLabel.heightAnchor.constraint(equalTo: originImageView.heightAnchor).isActive = true
        
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        cardView.fillSuperview(padding: UIEdgeInsets(top: 5,
                                                     left: 8,
                                                     bottom: 5,
                                                     right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
