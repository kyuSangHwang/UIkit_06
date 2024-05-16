//
//  RatingView.swift
//  JRNL
//
//  Created by 황규상 on 5/16/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons = [UIButton()] // UIStackView에 추가될 UIButton 인스턴스를 저장할 배열
    
    var rating = 0 { // 현재 선택된 레이팅 값, 변경 시 updateButtonSelectionState() 메서드 호출
        didSet {
            updateButtonSelectionState()
        }
    }
    
    // 버튼의 크기와 개수를 설정
    private let buttonSize = CGSize(width: 44.0, height: 44.0)
    private let buttonCount = 5
    
    // MARK: - Initialization
    required init(coder: NSCoder) { // 초기화 메서드, 주로 Interface Builder에서 사용됨
        super.init(coder: coder)
        setupButtons() // 뷰가 초기화될 때 버튼을 설정
    }
    
    // MARK: - Private Methods
    /// 버튼을 설정하는 메서드
    private func setupButtons() {
        for button in ratingButtons { // 기존 버튼을 스택뷰에서 제거하고 배열을 초기화
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // 버튼에 사용할 이미지 설정
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        
        for _ in 0..<buttonCount { // 지정된 개수만큼 버튼을 생성하여 스택뷰에 추가
            let button = UIButton()
            
            // 버튼의 이미지를 설정
            button.setImage(emptyStar, for: .normal)  // 기본 상태의 이미지
            button.setImage(filledStar, for: .selected)  // 선택된 상태의 이미지
            button.setImage(highlightedStar, for: .highlighted)  // 하이라이트된 상태의 이미지
            button.setImage(highlightedStar, for: [.highlighted, .selected])  // 선택되면서 하이라이트된 상태의 이미지
            
            // 버튼의 크기를 설정
            button.translatesAutoresizingMaskIntoConstraints = false
//            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
//            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            
            // 버튼이 눌렸을 때 호출될 메서드를 설정
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            // 버튼을 스택뷰에 추가하고 배열에 저장
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    // 현재 rating 값에 따라 버튼의 선택 상태를 업데이트하는 메서드
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            // 현재 인덱스가 rating 값보다 작으면 버튼을 선택 상태로 설정
            button.isSelected = index < rating
        }
    }
    
    // 버튼이 눌렸을 때 호출되는 메서드
    @objc func ratingButtonTapped(button: UIButton) {
        // 눌린 버튼의 인덱스를 찾음
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // 선택된 버튼의 인덱스를 기반으로 레이팅 값을 설정
        let selectedRating = index + 1
        
        // 같은 버튼을 다시 누르면 레이팅을 0으로 초기화
        if selectedRating == rating {
            rating = 0
        } else {
            // 새로운 레이팅 값을 설정
            rating = selectedRating
        }
    }
}
