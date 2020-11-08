//
//  ProductImage.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit
import SDWebImage

class ProductImage: UIViewController  {
    // MARK:- Properties
    private var imageURL: URL?
    var imageView =  UIImageView()
    
    // MARK:- Lifecycle
    convenience init(urlString: String) {
        self.init(nibName:nil, bundle:nil)
        guard let url = URL(string: urlString) else { return }
        imageURL = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK:- Configures
    private func configureUI() {
        view.backgroundColor = .clear
        view.addSubview(imageView)
        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "imageNotFound"))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    // MARK:- Selectors
    @objc
    private func openPromotion(_: UITapGestureRecognizer) {
        print("DEBUG:- touched!!")
    }
}
