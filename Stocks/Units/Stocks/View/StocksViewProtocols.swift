//
//  StocksViewProtocols.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

/// presenter -> view
protocol StocksViewInput: AnyObject {
	/// Метод устаналивает состояние загрузки
	/// - Parameter isLoading: Состояние загрузки
	func setLoading(_ isLoading: Bool)
	
	/// Метод отображения ошибки из модели
	/// - Parameter model: Модель ошибки
	func showError(_ model: ErrorModel)
	
	/// Метод отображения котировки из модели
	/// - Parameter model: Модель котировки
	func showQuote(_ model: QuoteModel)
	
	/// Метод сообщения о необходимости обновить список котировок
	func updateListQuotes()
}

/// view -> presenter
protocol StocksViewOutput {
	/// Список котировок
	var listQuote: [QuoteListModel] { get }
	
	/// Метод сообщает презентору о том, что вью загрузилось
	func viewLoaded()
	
	/// Метод получения котировки по символу
	/// - Parameter symbol: Символ котировки
	func fetchQuote(for symbol: String)
}
