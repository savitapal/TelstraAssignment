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
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
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
    
    let spacingValue: CGFloat = 15
    let containerViewSpacingValue: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerViewSpacingValue).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerViewSpacingValue).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacingValue).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacingValue).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacingValue).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacingValue).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacingValue).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacingValue).isActive = true
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(customImageView)
        customImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: spacingValue).isActive = true
        customImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: Constant.estimatedHeight).isActive = true
        customImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: spacingValue).isActive = true
        }
    }
}
