//
//  ProductCell.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // MARK:- Properties
    
//    var client: Franchisee? {
//        didSet { configure() }
//    }
//
//    private var cardImageView = UIImageView()
//    private lazy var discountLabel = CustomView().insetLabel(text: "--% 할인",
//                                     textColor: .grey8,
//                                     backgroundColor: .white,
//                                     inset: UIEdgeInsets(top: 2 + 2, left: 4, bottom: 4, right: 2))
//    private var clientName = UILabel()
//    private var distance = UILabel()
//    private var limitation = UILabel()

    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Selectors
    // MARK:- Configures
    private func configureUI() {
        
    }
    
    private func configure() {

    }
    // MARK:- Extentions
}
