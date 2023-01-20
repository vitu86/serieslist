//
//  DetailViewTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import XCTest

@testable import SeriesList

final class DetailViewTests: XCTestCase {
	var sut: DetailView!

	override func setUpWithError() throws {
		sut = DetailView()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testUpdate() {
		let subtToShow = DetailViewModel.stub()
		sut.update(show: subtToShow)

		let scrollView = sut.subviews.first { $0 is UIScrollView } as! UIScrollView
		let scrollContent = scrollView.subviews[0]
		let stack = scrollContent.subviews.first { $0 is UIStackView } as! UIStackView
		XCTAssertEqual(stack.arrangedSubviews.count, subtToShow.episodes.count)
	}
}
