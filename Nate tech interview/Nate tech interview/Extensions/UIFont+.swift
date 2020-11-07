//
//  UIFont_.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

extension UIFont {
    static func notoThin(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansCJKkr-Thin", size: size)
        else { return UIFont.systemFont(ofSize: size) }
        return font
    }
    
    static func notoReg(size: CGFloat) -> UIFont {
        guard let font =  UIFont(name: "NotoSansCJKkr-Regular", size: size)
        else { return UIFont.systemFont(ofSize: size) }
        return font
    }
    
    static func notoBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansCJKkr-Bold", size: size)
        else { return UIFont.boldSystemFont(ofSize: size)}
        return font
    }
    
    static func notoBlack(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "NotoSansCJKkr-Black", size: size)
        else { return UIFont.boldSystemFont(ofSize: size) }
        return font
    }
    
    static func hanSanReg(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "BlackHanSans-Regular", size: size)
        else { return UIFont.systemFont(ofSize: size) }
        return font
    }
}
