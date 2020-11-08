//
//  ProductCell.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // MARK:- ViewComponents
    public lazy var productImagePVC = ProductImagePVC()
    public let titleLabel = UILabel()
    public let popUpMerchantLabel = UILabel()
    public let popUpCreatedDateLabel = UILabel()
    public let popUpWebsiteButton = UIButton()
    private let detailButton = UIButton()
    private let visualEffectView = UIVisualEffectView()
    private let popUpFrame = UIView()
    private let popUpTitleLabel = UILabel()
    
    // MARK:- Properties
    public lazy var viewModel = HomeVM(self)
    public var imageStringURLs = [String]()
    public var webSiteURL = ""
    private var isDetailOn = false

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
        visualEffectView.alpha = 0
        popUpFrame.alpha = 0
        isDetailOn = false
    }
    
    private func configureUI() {
        addSubview(detailButton)
        detailButton.setTitle("detail", for: .normal)
        detailButton.titleLabel?.font = .notoBold(size: 18 * ratio)
        detailButton.addTarget(self, action: #selector(displayDetail), for: .touchUpInside)
        detailButton.setTitleColor(.gray6, for: .normal)
        detailButton.backgroundColor = .white
        detailButton.layer.cornerRadius = 10
        detailButton.snp.makeConstraints { make in
            make.width.equalTo(65 * ratio)
            make.height.equalTo(25 * ratio)
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-24)
        }
        
        addSubview(titleLabel)
        titleLabel.font = UIFont.notoReg(size: 24 * ratio)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalTo(detailButton.snp.left)
        }
        
        addSubview(productImagePVC.view)
        productImagePVC.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(frame.width * 0.8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        addSubview(visualEffectView)
        visualEffectView.effect = UIBlurEffect(style: .light)
        visualEffectView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        addSubview(popUpFrame)
        popUpFrame.backgroundColor = .white
        popUpFrame.layer.cornerRadius = 10
        popUpFrame.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(displayDetail)))
        popUpFrame.isUserInteractionEnabled = true
        popUpFrame.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        popUpFrame.addSubview(popUpTitleLabel)
        popUpTitleLabel.numberOfLines = 0
        popUpTitleLabel.textColor = .gray8
        popUpTitleLabel.font = .notoReg(size: 24 * ratio)
        popUpTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        popUpFrame.addSubview(popUpMerchantLabel)
        popUpMerchantLabel.textAlignment = .right
        popUpMerchantLabel.numberOfLines = 0
        popUpMerchantLabel.textColor = .gray7
        popUpMerchantLabel.font = .notoBold(size: 24 * ratio)
        popUpMerchantLabel.snp.makeConstraints { make in
            make.top.equalTo(popUpTitleLabel.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        
        popUpFrame.addSubview(popUpCreatedDateLabel)
        popUpCreatedDateLabel.textColor = .gray5
        popUpCreatedDateLabel.font = .notoReg(size: 18 * ratio)
        popUpCreatedDateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        popUpFrame.addSubview(popUpWebsiteButton)
        popUpWebsiteButton.setTitle("visit website", for: .normal)
        popUpWebsiteButton.titleLabel?.font = .notoReg(size: 18 * ratio)
        popUpWebsiteButton.setTitleColor(.gray5, for: .normal)
        popUpWebsiteButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        popUpWebsiteButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalTo(popUpCreatedDateLabel.snp.centerY)
        }
    }
    
    override func prepareForReuse() {
        visualEffectView.alpha = 0
        popUpFrame.alpha = 0
        isDetailOn = false
        productImagePVC.placeHolderImage.isHidden = true
        popUpWebsiteButton.isHidden = false
        if productImagePVC.imageStringURLs.count > 0 {
            productImagePVC.setViewControllers([productImagePVC.pages[0]], direction: .forward, animated: false)
            productImagePVC.pageControl.currentPage = 0
        }
    }
    
    @objc func displayDetail() {
        popUpTitleLabel.text = titleLabel.text
        if isDetailOn {
            isDetailOn = false
            UIView.animate(withDuration: 0.5) {
                self.visualEffectView.alpha = 0
                self.popUpFrame.alpha = 0
                self.popUpFrame.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
        } else {
            isDetailOn = true
            popUpFrame.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.5) {
                self.visualEffectView.alpha = 0.8
                self.popUpFrame.alpha = 1
                self.popUpFrame.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc func openWebsite() {
        guard let url = URL(string: webSiteURL) else { return }
        UIApplication.shared.open(url)
    }
}
