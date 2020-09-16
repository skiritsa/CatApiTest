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
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            breedNameLabel.text = viewModel.name
            originNameLabel.text = viewModel.origin
        }
    }
    
    //First layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.image = UIImage(named: "catPixel")
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        overlayFirstLayer()
        overlaySecondLayer()
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
        originImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        originImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //originNameLabel constraints
        originNameLabel.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor, constant: 10).isActive = true
        originNameLabel.leadingAnchor.constraint(equalTo: originImageView.trailingAnchor, constant: 5).isActive = true
        originNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        originNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
