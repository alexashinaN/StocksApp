//
//  StocksServiceProtocol.swift
//  Stocks
//
//  Created by Violence on 31.01.2021.
//

import Foundation

/// Интерфейс для работы со списком котировок
protocol StocksServiceProtocol {
	/// Метод для запроса общего списка котировок
	/// - Parameter completion: Результат запроса
	func getAllQuotes(completion: @escaping (Result<[ConcreteQuote], NetworkServiceError>) -> Void)
}
