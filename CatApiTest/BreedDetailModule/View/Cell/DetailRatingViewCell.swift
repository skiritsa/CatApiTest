//
//  DetailRatingViewCell.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 11.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class DetailRatingViewCell: UITableViewCell {

    static let reuseId = "DetailRatingCell"

    var viewModel: DetailCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel as? DetailRatingCellViewModel else { return }
            titleLabel.text = viewModel.title
            ratingView.rating = viewModel.rating
        }
    }

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    var ratingView: RatingStackView = {
        let ratingView = RatingStackView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()

    private func configTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    private func configRatingView() {
        addSubview(ratingView)
        ratingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        configTitleLabel()
        configRatingView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
