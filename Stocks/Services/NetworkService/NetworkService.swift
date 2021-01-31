//
//  NetworkService.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import Foundation

/// Список возможных ошибок сети
enum NetworkServiceError: Error {
	/// Доменная ошибка
	case domain(Error)
	/// HTTP ошибка
	case http(Int)
	/// Ошибка декодирования
	case decoding(Error)
	/// Некорректный ответ
	case brokenResponse
}

/// Сущность, которая взаимодействует с интернетом
final class NetworkService {
	private let base = "https://cloud.iexapis.com/stable/stock/"
	private let token = "pk_2a94e12cfc30498089ef35fb8a0a263c"
	private let session: URLSession
	
	init(session: URLSession) {
		self.session = session
	}
}

// MARK: - Request

private extension NetworkService {
	func request<U: Codable>(url: URL, completion: @escaping (Result<U, NetworkServiceError>) -> Void) {
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		let dataTask = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.domain(error)))
				return
			}
			
			guard let data = data, let response = response else {
				completion(.failure(.brokenResponse))
				return
			}
			
			if let statusCode = (response as? HTTPURLResponse)?.statusCode {
				if statusCode != 200 {
					completion(.failure(.http(statusCode)))
					return
				}
			}
			
			do {
				let concreteQuote = try JSONDecoder().decode(U.self, from: data)
				completion(.success(concreteQuote))
			} catch {
				completion(.failure(.decoding(error)))
			}
		}
		dataTask.resume()
	}
}

// MARK: - StocksServiceProtocol

extension NetworkService: StocksServiceProtocol {
	func getAllQuotes(completion: @escaping (Result<[ConcreteQuote], NetworkServiceError>) -> Void) {
		guard let url = URL(string: base + "market/list/mostactive?token=\(token)&listLimit=150") else { return }
		request(url: url, completion: completion)
	}
}
