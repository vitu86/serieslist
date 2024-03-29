//
//  DetailViewSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import UIKit

@testable import SeriesList

final class DetailViewSpy: UIView, DetailViewType {

	init() {
		super.init(frame: .zero)
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

	private(set) var hideLoadingCallCount = 0
	func hideLoading() {
		hideLoadingCallCount += 1
	}
}
