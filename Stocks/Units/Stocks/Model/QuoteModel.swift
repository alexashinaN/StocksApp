//
//  QuoteModel.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

/// UI модель отображения котировки
struct QuoteModel {
	let name: String
	let symbol: String
	let price: Double
	let priceChange: Double
	let urlImage: String
	let colorChange: UIColor
}
