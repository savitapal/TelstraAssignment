//
//  CustomCollectionViewCell.swift
//  Assignment
//
//  Created by test on 29/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    let customImageView: UIImageView = {
        let customImageView = UIImageView()
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.contentMode = .scaleAspectFit
        return customImageView
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        if UIDevice.current.userInterfaceIdiom == .pad {
            return contentView.systemLayoutSizeFitting(CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight))
        } else {
            return contentView.systemLayoutSizeFitting(CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight))
        }        
    }
    
    // Adding views and setting constraints
    
    fileprivate func setUpViews() {
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        contentView.addSubview(customImageView)
        customImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        customImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        customImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        customImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
}
