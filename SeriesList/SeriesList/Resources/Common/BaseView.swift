//
//  BaseView.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

final class BaseView: UIView {

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
}

// MARK: - Loading Functions
extension BaseView {
	private func configureAndShowLoading() {
		addSubview(loadingView)
		addLoadingConstraints()
		bringSubviewToFront(loadingView)
	}

	private func removeLoading() {
		loadingView.removeFromSuperview()
	}

	private func addLoadingConstraints() {
		loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
}

extension BaseView: BaseViewType {
	func showLoading() {
		configureAndShowLoading()
	}

	func hideLoading() {
		removeLoading()
	}
}
