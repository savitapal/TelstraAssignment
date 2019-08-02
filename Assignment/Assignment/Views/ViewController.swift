//
//  ViewController.swift
//  Assignment
//
//  Created by test on 26/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var cellId = "cell"
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        if UIDevice.current.userInterfaceIdiom == .pad {
            layout.estimatedItemSize = CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight)
        } else {
            layout.estimatedItemSize = CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight)
        }
        
        return layout
    }()
    
    var activityView: UIActivityIndicatorView!
    
    var spacingValue: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpViews()
        refreshCollectionView()
    }
    
    func setUpViews() {
        
        self.view.backgroundColor = UIColor.white
        
        setUpNavigationBar()
        setUpCollectionView()
        setUpActivityIndicator()
    }
    
    //Setting up collection view
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.layer.masksToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        // Setting constraint to collectionview
        
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: spacingValue).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: spacingValue).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: -spacingValue).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -spacingValue).isActive = true
    }
    
    // Setting up Activity indicator
    
    func setUpActivityIndicator() {
        
        activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.view.center
        activityView.backgroundColor = UIColor.black
        self.view.addSubview(activityView)
        
        activityView.layer.cornerRadius = 5.0
    }
    
    // Setting up Navigation bar
    
    func setUpNavigationBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCollectionView))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    // View refresh method
    
    @objc func refreshCollectionView() {
        
        self.activityView.startAnimating()

        DataViewModel.objDataViewModel.refreshCollectionData { (done) in
            if done {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.navigationItem.title = DataViewModel.objDataViewModel.title
                    
                    self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                      at: .top,
                                                      animated: true)
                    
                    self.activityView.stopAnimating()
                }
            } else {
                
                self.activityView.stopAnimating()
                
                let alert = UIAlertController(title: "Error", message: "Error while fetching data", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: UICollectionView Datasource and Delegate methods

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataViewModel.objDataViewModel.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CustomCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        if DataViewModel.objDataViewModel.dataArray.count > 0 && DataViewModel.objDataViewModel.dataArray.count > indexPath.item {
            
            let rowdata = DataViewModel.objDataViewModel.dataArray[indexPath.item]
            
            cell.titleLabel.text = rowdata.title
            cell.descriptionLabel.text = rowdata.description
            
            if let imageUrl = rowdata.imageHref {
                
                let url = URL(string: imageUrl)
                cell.customImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            } else {
                
                cell.customImageView.image = #imageLiteral(resourceName: "placeholder")
            }
        }
        
        return cell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            layout.estimatedItemSize = CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight)
        } else {
            layout.estimatedItemSize = CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight)
        }
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            layout.estimatedItemSize = CGSize(width: Constant.ipadWidth, height: Constant.estimatedHeight)
        } else {
            layout.estimatedItemSize = CGSize(width: Constant.iphoneWidth, height: Constant.estimatedHeight)
        }

        layout.invalidateLayout()
    }
    
}
