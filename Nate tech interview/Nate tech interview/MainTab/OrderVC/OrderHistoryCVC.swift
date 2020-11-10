//
//  OrderHistoryCVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/9/20.
//

import UIKit
protocol OrderHistoryDelegate: class {
    func orderTapped(index: Int)
}

class OrderHistoryCVC: UICollectionViewController {
    // MARK:- Properties
    private lazy var viewModel  = OrderVM(self)
    weak var delegate: OrderHistoryDelegate?
    public var orders = [Order]() {
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
        
        return CGSize(width: view.frame.width, height: view.frame.width * 0.45)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrderHistoryCell
        
        cell.status = viewModel.randomStatus()
        cell.viewModel.filterValues(product: orders[indexPath.row].product)
//        cell.delegate = delegate

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.orderTapped(index: indexPath.row)
    }
}
