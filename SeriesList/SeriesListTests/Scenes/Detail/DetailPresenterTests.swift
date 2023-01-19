//
//  DetailPresenterTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import XCTest

@testable import SeriesList

final class DetailPresenterTests: XCTestCase {
	var sut: DetailPresenter!
	var controllerSpy: DetailControllerSpy!
	var serviceSpy: ServiceSpy!
	var adapterSpy: DetailAdapterSpy!

	override func setUpWithError() throws {
		serviceSpy = ServiceSpy()
		adapterSpy = DetailAdapterSpy()
		sut = DetailPresenter(service: serviceSpy, adapter: adapterSpy, show: .stub())
		controllerSpy = DetailControllerSpy()

		sut.controller = controllerSpy
	}

	override func tearDownWithError() throws {
		controllerSpy = nil
		sut = nil
	}

	func testGetShowDetailSuccess() {

		serviceSpy.mockResultGetShowEpisodes = .success(.stub())
		adapterSpy.resultAdapt = .stub()

		sut.getShowDetail()

		XCTAssertEqual(controllerSpy.showLoadingCallCount, 1)
		XCTAssertEqual(serviceSpy.getShowEpisodesParam, TVShow.stub().id)
		XCTAssertEqual(controllerSpy.hideLoadingCallCount, 1)
		XCTAssertEqual(adapterSpy.adaptFirstParam, .stub())
		XCTAssertEqual(adapterSpy.adaptSecondParam, .stub())
		XCTAssertEqual(controllerSpy.updateCallParam, .stub())
	}

	func testGetShowDetailError() {

		serviceSpy.mockResultGetShowEpisodes = .failure(.generic)

		sut.getShowDetail()

		XCTAssertEqual(controllerSpy.showLoadingCallCount, 2)
		XCTAssertEqual(serviceSpy.getShowEpisodesParam, TVShow.stub().id)
		XCTAssertEqual(controllerSpy.hideLoadingCallCount, 2)
		XCTAssertEqual(controllerSpy.showErrorCallCount, 2)
		XCTAssertEqual(controllerSpy.showErrorParam, "Sorry, we couldn't load the show details")
	}
}
