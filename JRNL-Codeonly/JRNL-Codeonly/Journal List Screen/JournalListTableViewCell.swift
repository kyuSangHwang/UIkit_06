//
//  JournalListTableViewCell.swift
//  JRNL-Codeonly
//
//  Created by 황규상 on 5/13/24.
//

import UIKit

class JournalListTableViewCell: UITableViewCell {
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = Title"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return titleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(dateLabel)
        addSubview(titleLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide
        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.leadingAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
