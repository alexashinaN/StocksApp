//
//  QuoteView.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

/// Элемент для отображения котировки
final class QuoteView: UIView {
	
	// MARK: - Private property
	
	private let nameView = DescriptionView(description: "Company name")
	private let symbolView = DescriptionView(description: "Symbol")
	private let priceView = DescriptionView(description: "Price")
	private let changeView = DescriptionView(description: "Price change")
	private let stackView = UIStackView()
	
	// MARK: - Initialization
	
	init() {
		super.init(frame: .zero)
		self.configure()
		self.setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: stackView.intrinsicContentSize.height)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.shadowPath = UIBezierPath(rect: bounds).cgPath
	}
}

// MARK: - Public

extension QuoteView {
	/// Отоброжение данных котировки из модели
	/// - Parameter model: Модели котировки
	func display(model: QuoteModel) {
		func makeSeparator() -> UIView {
			let separatorView = UIView()
			separatorView.translatesAutoresizingMaskIntoConstraints = false
			separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
			separatorView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
			return separatorView
		}

		if stackView.arrangedSubviews.isEmpty {
			stackView.addArrangedSubview(nameView)
			stackView.addArrangedSubview(makeSeparator())
			stackView.addArrangedSubview(symbolView)
			stackView.addArrangedSubview(makeSeparator())
			stackView.addArrangedSubview(priceView)
			stackView.addArrangedSubview(makeSeparator())
			stackView.addArrangedSubview(changeView)
		}
		
		nameView.valueLabel.text = model.name
		symbolView.valueLabel.text = model.symbol
		priceView.valueLabel.text = String(model.price)
		changeView.valueLabel.text = String(model.priceChange)
		changeView.valueLabel.textColor = model.colorChange
	}
}

// MARK: - Configure, Layout

private extension QuoteView {
	func configure() {
		stackView.spacing = 1
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		stackView.isLayoutMarginsRelativeArrangement = true
		
		backgroundColor = .white
		layer.cornerRadius = 10.0
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		layer.shadowColor = UIColor.gray.cgColor
		layer.shadowOpacity = 0.2
		layer.shadowOffset = .zero
		layer.shadowRadius = 10
	}

	func setupLayout() {
		addSubviews(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.leftAnchor.constraint(equalTo: leftAnchor),
			stackView.rightAnchor.constraint(equalTo: rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
