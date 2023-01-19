//
//  DetailControllerTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import XCTest

@testable import SeriesList

final class DetailControllerTests: XCTestCase {
	var sut: DetailController!
	var presenterSpy: DetailPresenterSpy!
	var viewSpy: DetailViewSpy!

	override func setUpWithError() throws {
		viewSpy = DetailViewSpy()
		presenterSpy = DetailPresenterSpy()
		sut = DetailController(rootView: viewSpy, presenter: presenterSpy)
	}

	override func tearDownWithError() throws {
		viewSpy = nil
		presenterSpy = nil
		sut = nil
	}

	func testLoadView() {
		sut.loadView()
		XCTAssertEqual(sut.view, viewSpy)
	}

	func testViewDidLoad() {
		sut.viewDidLoad()
		XCTAssertEqual(presenterSpy.getShowDetailCallCount, 1)
	}

	func testUpdate() {
		let show = DetailViewModel.stub()
		sut.update(show: show)
		XCTAssertEqual(viewSpy.updateCallParam, show) 
	}
}
