//
//  DetailImageViewCell.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 12.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class DetailImageViewCell: UITableViewCell {
    static let reuseId = "DetailImageCell"

    var viewModel: DetailCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel as? DetailImageViewCellViewModel else { return }
            self.catImageView.set(imageURL: viewModel.imageUrl)
        }
    }

    var catImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        separatorInset = .zero
        configImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configImageView() {
        addSubview(catImageView)
        catImageView.fillSuperview()
    }
}
