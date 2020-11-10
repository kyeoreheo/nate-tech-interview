//
//  OrderDetailVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/9/20.
//

import UIKit

class OrderDetailVC: UIViewController {
    // MARK:- View components
    private let backButton = UIButton()
    private let scrollView = UIScrollView(frame: .zero)
    private var stackView: UIStackView?
    public lazy var productImagePVC = ProductImagePVC()
    public lazy var notificationView = MyPageVM(self).notificationView(text: "Track number had been copied")

    // MARK:- Properties
    private lazy var viewModel = OrderVM(self)
    private let product: API.ProductResponse
    var imageURLs = [String]()
    var status: DeliveryStatus = .orderReceived
    var productName = ""
    var merchant = ""
    var webSiteURL = ""
    var createdDate = ""
    var address = "45 River South #1509, Jersey City, NJ, 07310"
    var card = "****-****-****-3030"
    var trackNumber = "4938 2093 2934 AD82"
    var orderDate = Date()

    private var originalBannerTransform: CATransform3D?
    
    // MARK:- Lifecycle
    init(product: API.ProductResponse) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureConstraints()
    }
    
    // MARK:- Configures
    private func configure() {
        view.backgroundColor = .white
        scrollView.delegate = self
        viewModel.filterValues(product: product)
        status = viewModel.randomStatus()
        
        if product.images.count <= 1 {
            productImagePVC.view.subviews.forEach {
                if let scrollView = $0 as? UIScrollView {
                    scrollView.isScrollEnabled = false
                }
            }
        }
    }
    
    private func configureConstraints() {
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.left.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalToSuperview()
        }
        
        scrollView.addSubview(productImagePVC.view)
        productImagePVC.view.isUserInteractionEnabled = true
        productImagePVC.view.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.width)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        originalBannerTransform = productImagePVC.view.layer.transform
        
        let headerView = viewModel.orderDetailHeader(productName: productName, status: status, trackNumber: trackNumber, target: self, action: #selector(copyTrackNumber))
        
        let bodyView = viewModel.orderDetailBody(seller: merchant, recipient: "Kyeore Heo", website: webSiteURL, address: address, card: card, target: self, action: #selector(openWebsite))


        stackView = UIStackView(arrangedSubviews: [headerView, bodyView])
        guard let stackView = stackView else { return }
        
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.spacing = 16
        stackView.snp.makeConstraints { make in
            make.top.equalTo(productImagePVC.view.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview()
        }
    }
    
    func purchasedButtonTapped() {
        view.isUserInteractionEnabled = false
        view.addSubview(notificationView)
        notificationView.alpha = 0
        notificationView.snp.makeConstraints { make in
            make.height.equalTo(48 * ratio)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
        animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.notificationView.alpha = 1
            strongSelf.notificationView.frame.origin.y += (48 * ratio) + 16
        },
        completion: { [weak self] finished in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
            animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.notificationView.alpha = 0
                strongSelf.notificationView.frame.origin.y -= (48 * ratio) + 16
            },
            completion:  { [weak self] finished in
                guard let strongSelf = self else { return }
                strongSelf.notificationView.removeFromSuperview()
                strongSelf.view.isUserInteractionEnabled = true
            })}
        })
    }
    
    // MARK:- Selectors
    @objc func copyTrackNumber() {
        let pastedboard = UIPasteboard.general
        pastedboard.string = trackNumber
        purchasedButtonTapped()
    }
    
    @objc func openWebsite() {
        guard let url = URL(string: webSiteURL) else { return }
        UIApplication.shared.open(url)
    }

}

extension OrderDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let originalBannerTransform = originalBannerTransform
        else { return }
        
        if scrollView.contentOffset.y <= -130 {
            scrollView.contentOffset.y = -130
        }
        
        let currentOffset = -(scrollView.contentOffset.y + topSafeMargin)
        var bannerRatio = currentOffset / view.frame.width
        var headerY = -(view.frame.width + currentOffset)
        
        var imageTransform = CATransform3DIdentity
        
        if bannerRatio <= 0 { //when the offset is 0, go back to the origianl spot
            bannerRatio = 1
            productImagePVC.view.layer.transform = originalBannerTransform
            
        } else if bannerRatio <= 0.3 {
            let imageSizevariation = ((productImagePVC.view.bounds.height * (1.0 + bannerRatio)) - productImagePVC.view.bounds.height) / 2.0
            imageTransform = CATransform3DTranslate(imageTransform, 0, -imageSizevariation, 0)
            imageTransform = CATransform3DScale(imageTransform, 1.0 + bannerRatio, 1.0 + bannerRatio, 0)
            productImagePVC.view.layer.transform = imageTransform
        }
    }
}
