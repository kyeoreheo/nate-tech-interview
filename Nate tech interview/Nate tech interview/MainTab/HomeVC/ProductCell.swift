//
//  ProductCell.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // MARK:- Properties
    public let titleLabel = UILabel()
    public let image = UIImageView()
    public var imageStringURLs = [String]() {
        didSet {
            showPVC()
            configureUI()
        }
    }
    private let saveButton = UIButton()
    private lazy var productImagePVC = ProductImagePVC()

    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Configures
    private func configureView() {
        backgroundColor = .gray1
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.font = UIFont.notoReg(size: 24 * ratio)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        addSubview(image)
//        image.contentMode = .scaleAspectFit
//        image.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(8)
//            make.height.equalTo(frame.width * 0.8)
//            make.left.right.equalToSuperview()
//        }
        
        addSubview(productImagePVC.view)
        productImagePVC.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(frame.width * 0.8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            //make.bottom.equalToSuperview()
        }
    }
    
    private func showPVC() {
        let filteredURLs = imageStringURLs.filter{ isValidUrl(urlString: $0) }
        if filteredURLs.count > 0 {
            productImagePVC.imageStringURLs = filteredURLs
            productImagePVC.placeHolderImage.isHidden = true
        } else {
            productImagePVC.placeHolderImage.isHidden = false
        }
        
        if filteredURLs.count == 1 {
            productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = false
                }
            }
        } else {
            productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = true
                }
            }
        }


    }
    
    func isValidUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }

    // MARK:- Extentions
}
