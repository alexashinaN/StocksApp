//
//  UIFont+Extension.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

enum AvenirStyle: String {
	case light = "Avenir-Light"
	case medium = "Avenir-Medium"
}

extension UIFont {
	static func avenir(_ style: AvenirStyle, size: CGFloat) -> UIFont {
		return UIFont(name: style.rawValue, size: size) ?? UIFont()
	}
}
