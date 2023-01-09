//
//  LoadingView.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

class LoadingView: UIView {

	private let loadingIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .large)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		backgroundColor = .white
		addSubviews()
		addConstraints()
		loadingIndicator.startAnimating()
	}

	private func addSubviews() {
		addSubview(loadingIndicator)
	}

	private func addConstraints() {
		loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
}
