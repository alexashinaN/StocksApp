//
//  StocksPresenter.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

final class StocksPresenter {
	
	// MARK: - Private property
	
	private let service: StocksServiceProtocol
	private var quotes: [QuoteModel] = []
	
	// MARK: - Protocol property
	
	weak var view: StocksViewInput?
	var listQuote: [QuoteListModel] = []
	
	// MARK: - Initialize
	
	init(service: StocksServiceProtocol) {
		self.service = service
	}
}

// MARK: - StocksViewOutput

extension StocksPresenter: StocksViewOutput {
	func viewLoaded() {
		view?.setLoading(true)
		
		service.getAllQuotes { [weak self] response in
			DispatchQueue.main.async {
				self?.view?.setLoading(false)
			}
			switch response {
			case let .success(listQuote):
				self?.quotes = listQuote.map(\.toModel)
				self?.listQuote = listQuote.map(\.toListModel)
				DispatchQueue.main.async {
					self?.view?.updateListQuotes()
				}
			case let .failure(error):
				DispatchQueue.main.async {
					self?.handleError(error)
				}
			}
		}
	}
	
	func fetchQuote(for symbol: String) {
		guard let quote = quotes.first(where: { $0.symbol == symbol }) else {
			view?.showError(.init(title: "Ошибка", message: "Не удалось получить информациию о котировке", actionTitle: "Продолжить"))
			return
		}
		view?.showQuote(quote)
	}
}

// MARK: - Handle error

private extension StocksPresenter {
	func handleError(_ error: NetworkServiceError) {
		let model: ErrorModel
		switch error {
		case .brokenResponse:
			model = ErrorModel(title: "Ошибка", message: "Формат запроса неверен", actionTitle: "Понятно")
		case let .http(code):
			model = ErrorModel(title: "Ошибка", message: "Код ошибки: \(code)", actionTitle: "Понятно")
		case let .decoding(error):
			model = ErrorModel(title: "Ошибка декодирования ответа", message: error.localizedDescription, actionTitle: "Понятно")
		case let .domain(error):
			var handler: (() -> Void)?
			if (error as NSError).code == -1009 {
				handler = { [weak self] in
					self?.viewLoaded()
				}
			}
			model = ErrorModel(title: "Ошибка домена", message: error.localizedDescription, actionTitle: "Повторить", actionHandler: handler)
		}
		view?.showError(model)
	}
}

// MARK: - Map model

private extension ConcreteQuote {
	var toModel: QuoteModel {
		let color: UIColor
		if priceChange == 0 { color = .black }
		else if priceChange > 0 { color = .systemGreen }
		else { color = .systemRed }
		
		return QuoteModel(name: name, symbol: symbol, price: price, priceChange: priceChange, urlImage: urlImage, colorChange: color)
	}
	
	var toListModel: QuoteListModel {
		return QuoteListModel(name: name, symbol: symbol)
	}
}
