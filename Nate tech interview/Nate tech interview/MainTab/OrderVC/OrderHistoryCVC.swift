//
//  OrderHistoryCVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/9/20.
//

import UIKit

class OrderHistoryCVC: UICollectionViewController {
    // MARK:- Properties
    public lazy var viewModel  = OrderVM(self)
//    weak var delegate: ProductCellDelegate?
    public var products = [API.ProductResponse]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private let reuseIdentifier = "orderHistoryCell"
    
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
        collectionView.register(OrderHistoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK:- Extentions
extension OrderHistoryCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.width / 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrderHistoryCell
        
        let currentItem = products[indexPath.row]
        cell.viewModel.filterValues(productName: currentItem.title,
             imageStringURLs: currentItem.images,
             merchant: currentItem.merchant,
             createdAt: currentItem.createdAt,
             websiteURL: currentItem.url)
//        cell.delegate = delegate

        return cell
    }
}
