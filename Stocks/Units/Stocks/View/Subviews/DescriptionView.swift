//
//  DescriptionView.swift
//  Stocks
//
//  Created by Violence on 30.01.2021.
//

import UIKit

/// Элемент для отображения двух лейблов в ряд
final class DescriptionView: UIView {
	
	// MARK: - Private property
	
	private let descriptionLabel = UILabel()
	
	// MARK: - Public property
	
	let valueLabel = UILabel()
	
	// MARK: - Initialization
	
	init(description: String) {
		super.init(frame: .zero)
		self.descriptionLabel.text = description
		self.configure()
		self.setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: 50.0)
	}
}

// MARK: - Configure, Layout

private extension DescriptionView {
	func configure() {
		descriptionLabel.font = .avenir(.medium, size: 18.0)
		valueLabel.font = .avenir(.light, size: 18.0)
		valueLabel.adjustsFontSizeToFitWidth = true
		descriptionLabel.textAlignment = .left
		valueLabel.textAlignment = .right
		
		descriptionLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
		descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
		valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		valueLabel.setContentHuggingPriority(.required, for: .horizontal)
	}

	func setupLayout() {
		addSubviews(descriptionLabel, valueLabel)
		
		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
			descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor),
			
			valueLabel.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 10),
			valueLabel.topAnchor.constraint(equalTo: topAnchor),
			valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			rightAnchor.constraint(equalTo: valueLabel.rightAnchor)
		])
	}
}
