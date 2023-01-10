//
//  BaseController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

class BaseController: UIViewController {
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - State Control
extension BaseController {
	func showLoading() {
		(view as? BaseView)?.showLoading()
	}

	func hideLoading() {
		(view as? BaseView)?.hideLoading()
	}

	func showError() {
		print("ERROR")
		// show error view
	}
}
