//
//  RatingControl.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 16.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class RatingStackView: UIStackView {

    // MARK: Propeties
    private var ratingImageViews = [UIImageView]()
    var rating = 0 {
        didSet {
            updateImageViewSelectionState()
        }
    }

    var starSize: CGSize = CGSize(width: 20.0, height: 20.0)
    var starCount: Int = 5

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    // MARK: Private Methods

    private func setupButtons() {

        for _ in 0..<starCount {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true

            addArrangedSubview(imageView)
            ratingImageViews.append(imageView)
        }
    }

    private func updateImageViewSelectionState() {
        for (index, imageView) in ratingImageViews.enumerated() {
            let filledStar = UIImage(named: "filledStar")
            let emptyStar = UIImage(named: "emptyStar")

            if index < rating {
                imageView.image = filledStar
            } else {
                imageView.image = emptyStar
            }
        }
    }
}
