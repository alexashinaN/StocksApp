//
//  StocksViewController.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

final class StocksViewController: UIViewController {
	
	// MARK: - Private property
	
	private let imageView = UIImageView()
	private let output: StocksViewOutput
	private let companyPicker = UIPickerView()
	private let quoteView = QuoteView()
	private let loadIndicator = UIActivityIndicatorView(style: .whiteLarge)
	
	// MARK: - Initialization
	
	init(output: StocksViewOutput) {
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configure()
		setupLayout()
		output.viewLoaded()
	}
}

// MARK: - Configure, Layout

private extension StocksViewController {
	func configure() {
		view.backgroundColor = .white
		companyPicker.dataSource = self
		companyPicker.delegate = self
		loadIndicator.hidesWhenStopped = true
		loadIndicator.color = .gray
		imageView.contentMode = .scaleAspectFit
	}

	func setupLayout() {
		view.addSubviews(imageView, quoteView, companyPicker, loadIndicator)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 128),
			imageView.widthAnchor.constraint(equalToConstant: 128),
			
			quoteView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.0),
			quoteView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
			view.rightAnchor.constraint(equalTo: quoteView.rightAnchor, constant: 20.0),
			
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: companyPicker.bottomAnchor, constant: 10),
			companyPicker.leftAnchor.constraint(equalTo: view.leftAnchor),
			companyPicker.rightAnchor.constraint(equalTo: view.rightAnchor),
			companyPicker.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
			
			loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
}

// MARK: - StocksViewInput

extension StocksViewController: StocksViewInput {
	func showError(_ model: ErrorModel) {
		let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
		alert.addAction(.init(title: model.actionTitle, style: .default) { _ in
			model.actionHandler?()
		})
		present(alert, animated: true)
	}
	
	func updateListQuotes() {
		companyPicker.reloadAllComponents()
		let index = lround(Double(output.listQuote.count) / 2)
		companyPicker.selectRow(index, inComponent: 0, animated: true)
		pickerView(companyPicker, didSelectRow: index, inComponent: 0)
	}
	
	func showQuote(_ model: QuoteModel) {
		quoteView.display(model: model)
		guard let url = URL(string: model.urlImage) else { return }
		imageView.load(url: url)
	}
	
	func setLoading(_ isLoading: Bool) {
		companyPicker.isHidden = isLoading
		isLoading ? loadIndicator.startAnimating() : loadIndicator.stopAnimating()
	}
}

// MARK: - UIPickerViewDataSource

extension StocksViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return output.listQuote.count
	}
}

// MARK: - UIPickerViewDelegate

extension StocksViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return output.listQuote[row].name
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		output.fetchQuote(for: output.listQuote[row].symbol)
	}
}
