//
//  ConcreteQuote.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

/// DTO котировки
struct ConcreteQuote: Codable {
	private enum CodingKeys: String, CodingKey {
		case name = "companyName"
		case price = "latestPrice"
		case priceChange = "change"
		case symbol
	}
	
	let name: String
	let symbol: String
	let price: Double
	let priceChange: Double
	
	var urlImage: String {
		return "https://storage.googleapis.com/iex/api/logos/\(symbol).png"
	}
}
