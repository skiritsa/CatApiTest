//
//  RatingControl.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 16.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {

    // MARK: Propeties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
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
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load button image
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            
            //Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            
            
            // Add constaints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Add the button to the stack
            addArrangedSubview(button)
                
            // Add the new button on the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }

    private func updateButtonSelectionState() {
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
