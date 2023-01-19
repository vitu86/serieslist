//
//  DetailControllerSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import UIKit

@testable import SeriesList

final class DetailControllerSpy: UIViewController, DetailControllerType {
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private(set) var updateCallParam: DetailViewModel?
	func update(show: DetailViewModel) {
		updateCallParam = show
	}

	private(set) var showLoadingCallCount = 0
	func showLoading() {
		showLoadingCallCount += 1
	}

	private var showErrorShouldCallTryAgain = true
	private(set) var showErrorCallCount = 0
	private(set) var showErrorParam: String?
	func showError(_ message: String, tryAgainFunction: (() -> Void)?) {
		showErrorCallCount += 1
		showErrorParam = message
		if showErrorShouldCallTryAgain {
			showErrorShouldCallTryAgain = false
			tryAgainFunction?()
		}
	}

	private(set) var hideLoadingCallCount = 0
	func hideLoading() {
		hideLoadingCallCount += 1
	}
}
