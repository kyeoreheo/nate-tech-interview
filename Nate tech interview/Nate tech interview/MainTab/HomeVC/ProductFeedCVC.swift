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
    private let reuseIdentifier = "nearMeCell"
    
    weak var delegate: ProductFeedCVCDelegate?

    // MARK:- Lifecycle
    override init(collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
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
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @objc func productTapped(index: Int) {
        delegate?.productTapped(index: index)
    }

}
// MARK:- Extentions

extension ProductFeedCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 288, height: 144)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if franchisees.count > 0 {
//            return franchisees.count
//        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
//        if franchisees.count > 0 {
//            cell.client = franchisees[indexPath.row]
//        }
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productTapped(index: indexPath.row)
    }
}
