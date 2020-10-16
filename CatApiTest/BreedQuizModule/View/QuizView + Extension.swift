//
//  QuizView + Extension.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 05.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

extension QuizView {

    func makeImageView() -> WebImageView {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 56).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        return imageView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What breed is the cat in the picture?"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        addSubview(label)

        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        return label
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.isHidden = true

        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: reloadQuizButton.topAnchor, constant: -15).isActive = true

        setButton(stackView: stackView)

        return stackView
    }

    func setButton(stackView: UIStackView) {
        for i in 0...3 {
            let button = UIButton()
            button.backgroundColor = ColorConstant.firstColor
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(checkResponse(_:)), for: .touchUpInside)
            button.tag = i

            stackView.addArrangedSubview(button)
            buttonArray.append(button)
        }
    }

    func makeActivityIndicator() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true

        addSubview(loader)

        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        return loader
    }

    func makeReloadQuizButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(reloadQuiz), for: .touchUpInside)

        addSubview(button)

        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        return button
    }
}
