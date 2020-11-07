//
//  ProductFeedCVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

protocol ProductFeedCVCDelegate: class {
    func productTapped(index: Int)
}

class ProductFeedCVC: UICollectionViewController {
    // MARK:- Properties
    private var products = [API.ProductResponse]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private let reuseIdentifier = "productCell"
    
    weak var delegate: ProductFeedCVCDelegate?

    // MARK:- Lifecycle
    override init(collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .vertical
        myLayout.minimumLineSpacing = 16
        super.init(collectionViewLayout: myLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK:- Configures
    private func configure() {
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    public func setProduct(_ products: [API.ProductResponse]) {
        self.products = products
    }
    
    @objc func productTapped(index: Int) {
        delegate?.productTapped(index: index)
    }

}
// MARK:- Extentions

extension ProductFeedCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        if products[indexPath.row].title.count <= 0 {
            cell.titleLabel.text = "Name is missing.\nWe are looking for it!🤓"
        } else {
            cell.titleLabel.text = products[indexPath.row].title
        }
        
        if products[indexPath.row].images.count > 0 {
            cell.imageStringURLs = products[indexPath.row].images
        }
        
        if products[indexPath.row].merchant.count <= 0 {
            cell.popUpMerchantLabel.text = "by UNKNOWN seller 🧐"
        } else {
            cell.popUpMerchantLabel.text = "by \(products[indexPath.row].merchant)"
        }
        
        let createdAt = products[indexPath.row].createdAt
        cell.popUpCreatedDateLabel.text = createdAt.substring(to: 10)
        return cell
    }

}
