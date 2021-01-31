//
//  UIView+Extension.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
}
