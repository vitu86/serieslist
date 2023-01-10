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


extension BaseController: BaseControllerType {
	func showLoading() {
		(view as? BaseViewType)?.showLoading()
	}

	func hideLoading() {
		(view as? BaseViewType)?.hideLoading()
	}

	func showError() {
		(view as? BaseViewType)?.showError()
	}
}
