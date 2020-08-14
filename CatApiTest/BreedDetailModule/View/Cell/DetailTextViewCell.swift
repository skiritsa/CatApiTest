//
//  DetailTextViewCell.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 30.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class DetailTextViewCell: UITableViewCell {
    
    static let reuseId = "DetailTextViewCell"
    
    var viewModel: DetailCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel as? DetailTextCellViewModel else { return }
            titleLabel.text = viewModel.title.uppercased()
            breedPropertyLabel.text = viewModel.text.uppercased()
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    var breedPropertyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private func configTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func configBreedPropertyLabel() {
        addSubview(breedPropertyLabel)
        breedPropertyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        breedPropertyLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -40).isActive = true
        breedPropertyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        breedPropertyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        configTitleLabel()
        configBreedPropertyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
