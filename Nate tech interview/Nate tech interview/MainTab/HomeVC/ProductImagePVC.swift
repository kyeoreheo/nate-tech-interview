//
//  ProductImagePVC.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

struct PartnerBannerResponse {
    var urlString = ""
}

class ProductImagePVC: UIPageViewController {
    // MARK:- Properties
    var imageStringURLs = [String]() {
        didSet {
            generatePages()
        }
    }

    public var hi = ""
    private var pages = [UIViewController]()
    private let pageControl = UIPageControl()
    public let placeHolderImage = UIImageView()
    private var currentIndex = 0 {
        didSet {
            print("CurrentIndex \(currentIndex)")
        }
    }
    

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

    // MARK:- Helpers
    private func generatePages() {
        pages = imageStringURLs.compactMap{ ProductImage(urlString: $0) }
        setViewControllers([pages[0]], direction: .forward, animated: false)
        pageControl.numberOfPages = pages.count
    }
}

// MARK:- Extension
extension ProductImagePVC : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController)
        else { return nil }
        let prevIndex = index - 1
        if prevIndex < 0 { return pages.last }
        currentIndex = index

        return pages[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController)
        else { return nil }
        let nextIndex = index + 1

        if nextIndex > pages.count - 1 { return pages.first }
        print("pageVC \(nextIndex)")
        currentIndex = index

        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}
