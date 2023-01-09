//
//  BaseView.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

class BaseView: UIView {

	private lazy var loadingView: LoadingView = {
		let view = LoadingView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	init() {
		super.init(frame: .zero)
		backgroundColor = .white
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	open func update(element: Any) {}
}

// MARK: - Loading Functions
extension BaseView {
	func showLoading() {
		addSubview(loadingView)
		addLoadingConstraints()
		bringSubviewToFront(loadingView)
	}

	func hideLoading() {
		loadingView.removeFromSuperview()
	}

	private func addLoadingConstraints() {
		loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		loadingView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		loadingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
}
