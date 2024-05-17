//
//  RatingView.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/17/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons: [UIButton] = []
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    private let buttonSize = CGSize(width: 44, height: 44)
    private let buttonCount = 5
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons() {
        self.distribution = .fillEqually
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")?
            .withTintColor(.red,
                           renderingMode: .alwaysOriginal)
        for _ in 0..<buttonCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .highlighted)
            button.setImage(emptyStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchDown)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }

}
