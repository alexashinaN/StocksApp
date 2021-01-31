//
//  ErrorModel.swift
//  Stocks
//
//  Created by Violence on 31.01.2021.
//

/// Модель отображения ошибок
struct ErrorModel {
	/// Заголовок
	let title: String
	/// Сообщение
	let message: String
	/// Заголовок кнопки
	let actionTitle: String
	/// Действие при нажатии на кнопку
	let actionHandler: (() -> Void)?
	
	init(title: String, message: String, actionTitle: String, actionHandler: (() -> Void)? = nil) {
		self.title = title
		self.message = message
		self.actionTitle = actionTitle
		self.actionHandler = actionHandler
	}
}
