//
//  SearchVM.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class OrderVM {
    private let viewController: Any
    
    init(_ vc: Any) {
        self.viewController = vc
    }
    
    func getProducts() {
        guard let vc = viewController as? OrderVC else { return }
        API.getProducts() { response in
            guard let data = response?.data else { return }
            vc.products = data.products
        }
    }
    
    func filterValues(productName: String, imageStringURLs: [String], merchant: String, createdAt: String, websiteURL: String) {
        guard let cell = viewController as? OrderHistoryCell
        else { return }
        
        if productName.count > 0 {
            cell.productName.text = productName
        } else {
            cell.productName.text = "Name is missing.\nWe are looking for it!🤓"
        }
        
//        if merchant.count > 0 {
//            cell.popUpMerchantLabel.text = "by \(merchant)"
//        } else {
//            cell.popUpMerchantLabel.text = "by UNKNOWN seller 🧐"
//        }
//
//        cell.popUpCreatedDateLabel.text = createdAt.substring(to: 10)
//
//        if !isValidUrl(urlString: websiteURL) {
//            cell.popUpWebsiteButton.isHidden = true
//        }
//
        let filteredURLs = imageStringURLs.filter {
            isValidUrl(urlString: $0)
        }
        if filteredURLs.count > 0 {
            cell.productImage.sd_setImage(with: URL(string: filteredURLs[0]),placeholderImage: UIImage(named: "imageNotFound"))
        } else {
            cell.productImage.image = UIImage(named: "imageComingSoon")
        }
    }
    
    func statusBar() -> UIView {
        let view = UIView()
        let receivedCircle = UIView()
        let receivedLabel = UILabel()
        let bar1 = UIView()
        let shippedCircle = UIView()
        let shippedLabel = UILabel()
        let bar2 = UIView()
        let deliveredCircle = UIView()
        let deliveredLabel = UILabel()
        
        view.addSubview(receivedCircle)
        receivedCircle.tag = 1
        receivedCircle.backgroundColor = .gray5
        receivedCircle.layer.cornerRadius = 25
        receivedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(receivedLabel)
        receivedLabel.text = "received"
        receivedLabel.textColor = .gray5
        receivedLabel.font = .notoReg(size: 12 * ratio)
        receivedLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedCircle.snp.bottom).offset(4)
            make.centerX.equalTo(receivedCircle.snp.centerX)
        }
        
        view.addSubview(shippedCircle)
        shippedCircle.tag = 2
        shippedCircle.backgroundColor = .gray5
        shippedCircle.layer.cornerRadius = 25
        shippedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalToSuperview()
        }
        
        view.addSubview(shippedLabel)
        shippedLabel.text = "shipped"
        shippedLabel.textColor = .gray5
        shippedLabel.font = .notoReg(size: 12 * ratio)
        shippedLabel.snp.makeConstraints { make in
            make.top.equalTo(shippedCircle.snp.bottom).offset(4)
            make.centerX.equalTo(shippedCircle.snp.centerX)
        }
        
        view.addSubview(deliveredCircle)
        deliveredCircle.tag = 3
        deliveredCircle.layer.cornerRadius = 25
        deliveredCircle.backgroundColor = .gray5
        deliveredCircle.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(deliveredLabel)
        deliveredLabel.text = "delivered"
        deliveredLabel.textColor = .gray5
        deliveredLabel.font = .notoReg(size: 12 * ratio)
        deliveredLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveredCircle.snp.bottom).offset(4)
            make.centerX.equalTo(deliveredCircle.snp.centerX)
        }
        
        view.addSubview(bar1)
        bar1.tag = 10
        bar1.backgroundColor = .gray5
        bar1.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.left.equalTo(receivedCircle.snp.centerX)
            make.right.equalTo(shippedCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(bar2)
        bar2.tag = 20
        bar2.backgroundColor = .gray5
        bar2.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.left.equalTo(shippedCircle.snp.centerX)
            make.right.equalTo(deliveredCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        return view
    }
    
}
