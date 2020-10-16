//
//  DetailDescriptionViewCell.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 09.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class DetailDescriptionViewCell: UITableViewCell {

    static let reuseId = "DetailDescriptionCell"

    var viewModel: DetailCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel as? DetailDescriptionCellViewModel else { return }
            titleLabel.text = viewModel.title
            textView.text = viewModel.text
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    let textView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.numberOfLines = 0
        return textView
    }()

    private func configTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func configTextView() {
        addSubview(textView)
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        configTitleLabel()
        configTextView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
