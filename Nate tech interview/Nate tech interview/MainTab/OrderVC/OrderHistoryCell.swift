//
//  OrderHistoryCell.swift
//  Nate tech interview
//
//  Created by Kyo on 11/9/20.
//

import UIKit

class OrderHistoryCell: UICollectionViewCell {
    // MARK:- ViewComponents

    // MARK:- Properties
    public lazy var viewModel = OrderVM(self)
    public let productImage = UIImageView()
    public let productName = UILabel()
    public let trackNumberLabel = UILabel()
    public let currentStatusLabel = UILabel()
    public lazy var statusBar = viewModel.statusBar()
    
    public var status: DeliveryStatus = .orderReceived
    
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .gray1
    }
    
    private func configureUI() {
        addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.snp.makeConstraints { make in
            make.width.height.equalTo(65 * ratio)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(24)
        }
        
        addSubview(productName)
        productName.font = UIFont.notoReg(size: 18 * ratio)
        productName.numberOfLines = 2
        productName.textColor = .black
        productName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(productImage.snp.right).offset(8)
            make.right.equalToSuperview().offset(-24)
        }
        
        addSubview(currentStatusLabel)
        if status == .pending || status == .missing {
            currentStatusLabel.textColor = .red
        } else {
            currentStatusLabel.textColor = .black
        }
        currentStatusLabel.font = UIFont.notoReg(size: 14 * ratio)
        currentStatusLabel.textColor = .gray7
        currentStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom)
            make.left.equalToSuperview().offset(24)
        }
        
        addSubview(statusBar)
        statusBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(currentStatusLabel.snp.bottom)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    
    }

}
