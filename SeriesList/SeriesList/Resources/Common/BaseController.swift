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

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoading()
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
}
