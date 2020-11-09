//
//  Global.swift
//  Nate tech interview
//
//  Created by Kyo on 11/6/20.
//

import UIKit

var ratio: CGFloat = 0
var isBigPhone = false
var buttonConstraint: NSLayoutConstraint?
var bottomSafeMargin: CGFloat = 0
var topSafeMargin: CGFloat = 0

enum TextFieldType {
    case phone
    case address
    case card
    case password
    case email
}
