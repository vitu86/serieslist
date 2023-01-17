//
//  BaseController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

final class BaseController: UIViewController {
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

	func showError(_ message: String, tryAgainFunction: (() -> Void)? = nil) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: L10n.string(for: "ErrorActionConfirm"), style: .default) { _ in
			tryAgainFunction?()
		}
		alert.addAction(action)
		present(alert, animated: true)
	}
}
