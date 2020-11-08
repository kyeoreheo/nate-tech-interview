//
//  ProductImagePVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

class ProductImagePVC: UIPageViewController {
    // MARK:- Properties
    private lazy var viewModel = HomeVM(self)
    var imageStringURLs = [String]() {
        didSet {
            viewModel.generatePages()
        }
    }
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    public let placeHolderImage = UIImageView()
    
    // MARK:- Lifecycle
    init() {
        super.init(transitionStyle: .scroll,
              navigationOrientation: .horizontal,
              options: [UIPageViewController.OptionsKey.interPageSpacing : 0])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureUI()
    }
    
    // MARK:- Configures
    private func configureView() {
        view.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        placeHolderImage.isHidden = true
    }
    
    private func configureUI() {
        view.addSubview(pageControl)
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(placeHolderImage)
        placeHolderImage.image = UIImage(named: "imageComingSoon")
        placeHolderImage.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK:- Extension
extension ProductImagePVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController)
        else { return nil }
        let prevIndex = index - 1
        if prevIndex < 0 { return pages.last }
        return pages[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController)
        else { return nil }
        let nextIndex = index + 1
        if nextIndex > pages.count - 1 { return pages.first }
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}
