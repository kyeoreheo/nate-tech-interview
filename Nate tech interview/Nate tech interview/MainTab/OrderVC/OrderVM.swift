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
//        API.getProducts() { response in
//            guard let data = response?.data else { return }
//            vc.products = data.products
//        }
        vc.orders = User.shared.orders
    }
    
    /// Filter product for HistoryCell
    func filterValues(product: API.ProductResponse) {
        if let cell = viewController as? OrderHistoryCell {
            if product.title.count > 0 {
                cell.productName.text = product.title
            } else {
                cell.productName.text = "Name is missing.\nWe are looking for it!🤓"
            }
            
            applyStatus(status: cell.status, bar: cell.statusBar)
            cell.currentStatusLabel.text = statusText(status: cell.status)

            let filteredURLs = product.images.filter {
                isValidUrl(urlString: $0)
            }
            
            if filteredURLs.count > 0 {
                cell.productImage.sd_setImage(with: URL(string: filteredURLs[0]),placeholderImage: UIImage(named: "imageNotFound"))
            } else {
                cell.productImage.image = UIImage(named: "imageComingSoon")
            }
        } else if let vc = viewController as? OrderDetailVC {
            if product.title.count > 0 {
                vc.productName = product.title
            } else {
                vc.productName = "Name is missing.\nWe are looking for it!🤓"
            }
            
            if product.merchant.count > 0 {
                vc.merchant = "by \(product.merchant)"
            } else {
                vc.merchant = "by UNKNOWN seller 🧐"
            }
            
            vc.createdDate = product.createdAt.substring(to: 10)
            vc.webSiteURL = product.url
            if !isValidUrl(urlString: product.url) {
                //vc.popUpWebsiteButton.isHidden = true
            }
            
            let filteredURLs = product.images.filter {
                isValidUrl(urlString: $0)
            }
            
            if filteredURLs.count > 0 {
                vc.productImagePVC.imageStringURLs = removeDuplicates(filteredURLs)
            } else {
                vc.productImagePVC.placeHolderImage.isHidden = false
            }
            
            if filteredURLs.count <= 1 {
                vc.productImagePVC.view.subviews.forEach {
                    if let scrollView = $0 as? UIScrollView {
                        scrollView.isScrollEnabled = false
                    }
                }
            } else {
                vc.productImagePVC.view.subviews.forEach {
                    if let scrollView = $0 as? UIScrollView {
                        scrollView.isScrollEnabled = true
                    }
                }
            }
        }
    }

    func statusText(status: DeliveryStatus) -> String {
        switch status {
        case .orderReceived:
            return "Status: order received 👍🏼"
        case .shipped:
            return "Status: order received 🚛"
        case .delivered:
            return "Status: deliverd 🎁"
        case .pending:
            return "Status: pending 🧐"
        case .missing:
            return "Status: missing 🤔"
        case .refunded:
            return "Status: refunded 🚛"
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
        let circleSize: CGFloat = 30 * ratio
        view.addSubview(bar1)
        view.addSubview(bar2)
        view.addSubview(receivedCircle)
        receivedCircle.tag = 1
        receivedCircle.backgroundColor = .gray5
        receivedCircle.layer.cornerRadius = circleSize / 2
        receivedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
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
        shippedCircle.layer.cornerRadius = circleSize / 2
        shippedCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
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
        deliveredCircle.layer.cornerRadius = circleSize / 2
        deliveredCircle.backgroundColor = .gray5
        deliveredCircle.snp.makeConstraints { make in
            make.width.height.equalTo(circleSize)
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
        
        bar1.tag = 10
        bar1.backgroundColor = .gray5
        bar1.snp.makeConstraints { make in
            make.height.equalTo(5 * ratio)
            make.left.equalTo(receivedCircle.snp.centerX)
            make.right.equalTo(shippedCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        bar2.tag = 20
        bar2.backgroundColor = .gray5
        bar2.snp.makeConstraints { make in
            make.height.equalTo(5 * ratio)
            make.left.equalTo(shippedCircle.snp.centerX)
            make.right.equalTo(deliveredCircle.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        return view
    }
    
    func randomStatus() -> DeliveryStatus {
        let randomNumber = Int.random(in: 0...6)
        return DeliveryStatus(rawValue: randomNumber) ?? .orderReceived
    }
    
    func applyStatus(status: DeliveryStatus, bar: UIView) {
        guard let orderReceivedCircle =  bar.viewWithTag(1) as? UIView,
              let shippedCircle =  bar.viewWithTag(2) as? UIView,
              let deliveredCircle =  bar.viewWithTag(3) as? UIView,
              let bar1 = bar.viewWithTag(10) as? UIView,
              let bar2 = bar.viewWithTag(20) as? UIView
        else { return }
        switch status {
        case .orderReceived:
            orderReceivedCircle.backgroundColor = .orange
            shippedCircle.backgroundColor = .gray5
            deliveredCircle.backgroundColor = .gray5
            bar1.backgroundColor = .gray5
            bar2.backgroundColor = .gray5
        case .shipped:
            orderReceivedCircle.backgroundColor = .orange
            shippedCircle.backgroundColor = .orange
            deliveredCircle.backgroundColor = .gray5
            bar1.backgroundColor = .orange
            bar2.backgroundColor = .gray5
        case .delivered:
            orderReceivedCircle.backgroundColor = .orange
            shippedCircle.backgroundColor = .orange
            deliveredCircle.backgroundColor = .orange
            bar1.backgroundColor = .orange
            bar2.backgroundColor = .orange
        case .pending, .missing:
            orderReceivedCircle.backgroundColor = .red
            shippedCircle.backgroundColor = .red
            deliveredCircle.backgroundColor = .red
            bar1.backgroundColor = .red
            bar2.backgroundColor = .red
        case .refunded:
            orderReceivedCircle.backgroundColor = .gray5
            shippedCircle.backgroundColor = .gray5
            deliveredCircle.backgroundColor = .gray5
            bar1.backgroundColor = .gray5
            bar2.backgroundColor = .gray5
        }
    }
    
    func orderDetailHeader(productName: String, status: DeliveryStatus, trackNumber: String, target: Any, action: Selector) -> UIView {
        let view = UIView()
        let productNameLable = UILabel()
        let currentStatusLabel = UILabel()
        let bar = statusBar()
        let trackNumberLabel = UILabel()
        let copyButton = UIButton()
        
        view.addSubview(productNameLable)
        productNameLable.text = productName
        productNameLable.font = UIFont.notoBold(size: 18 * ratio)
        productNameLable.numberOfLines = 0
        productNameLable.textColor = .black
        productNameLable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(currentStatusLabel)
        currentStatusLabel.text = statusText(status: status)
        if status == .pending || status == .missing {
            currentStatusLabel.textColor = .red
        } else {
            currentStatusLabel.textColor = .gray8
        }
        
        currentStatusLabel.font = .notoReg(size: 14 * ratio)
        currentStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLable.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(bar)
        applyStatus(status: status, bar: bar)
        bar.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.top.equalTo(currentStatusLabel.snp.bottom)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(copyButton)
        copyButton.addTarget(target, action: action, for: .touchUpInside)
        copyButton.setImage(UIImage(named: "copy"), for: .normal)
        copyButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(bar.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        view.addSubview(trackNumberLabel)
        trackNumberLabel.textColor = .gray8
        trackNumberLabel.text = "Track number: \(trackNumber)"
        trackNumberLabel.font = .notoReg(size: 14 * ratio)
        trackNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(copyButton.snp.centerY)
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(copyButton.snp.left).offset(-8)
        }
        
        return view
    }
    
    func orderDetailBody(seller: String, recipient: String, website: String, address: String, card: String, target: Any, action: Selector) -> UIView {
        let view = UIView()
        let sellerLabel = UILabel()
        let visitWebsiteButton = UIButton()
        let recipientNameLabel = UILabel()
        let addressLabel = UILabel()
        let cardLabel = UILabel()
        
        view.addSubview(sellerLabel)
        sellerLabel.text = "Sender: \(seller)"
        sellerLabel.numberOfLines = 0
        sellerLabel.textColor = .gray8
        sellerLabel.font = .notoReg(size: 14 * ratio)
        sellerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        if website != "" {
            view.addSubview(visitWebsiteButton)
            visitWebsiteButton.addTarget(target, action: action, for: .touchUpInside)
            visitWebsiteButton.setTitle("visit website", for: .normal)
            visitWebsiteButton.titleLabel?.font = .notoReg(size: 14 * ratio)
            visitWebsiteButton.setTitleColor(.gray5, for: .normal)
            visitWebsiteButton.snp.makeConstraints { make in
                make.top.equalTo(sellerLabel.snp.bottom).offset(4)
                make.left.equalToSuperview().offset(24)
            }
        }
        
        view.addSubview(recipientNameLabel)
        recipientNameLabel.text = "Recipient: \(recipient)"
        recipientNameLabel.textColor = .gray8
        recipientNameLabel.font = .notoReg(size: 14 * ratio)
        recipientNameLabel.snp.makeConstraints { make in
            if website != "" {
                make.top.equalTo(visitWebsiteButton.snp.bottom).offset(4)
            } else {
                make.top.equalTo(sellerLabel.snp.bottom).offset(4)
            }
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        view.addSubview(addressLabel)
        addressLabel.text = "Address: \(address)"
        addressLabel.numberOfLines = 0
        addressLabel.font = .notoReg(size: 14 * ratio)
        addressLabel.textColor = .gray8
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(recipientNameLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        view.addSubview(cardLabel)
        cardLabel.text = "Card: \(card)"
        cardLabel.numberOfLines = 0
        cardLabel.font = .notoReg(size: 14 * ratio)
        cardLabel.textColor = .gray8
        cardLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
        return view
    }
    
    func orderDetailFooter() -> UIView {
        let view = UIView()
        let productNameLable = UILabel()
        let visitWebsite = UIButton()
        let merchantNameLabel = UILabel()
        
        return view
    }
}
