//
//  DetailAdapterTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import XCTest

@testable import SeriesList

final class DetailAdapterTests: XCTestCase {
	var sut: DetailAdapter!

	override func setUpWithError() throws {
		sut = DetailAdapter()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testAdapt() {
		let result = sut.adapt(show: .stub(), episodes: .stub())
		XCTAssertEqual(result, .stub())
	}

	func testAdaptWithCornerCases() {
		var episodesStub = [Episode].stub()
		episodesStub.append(.init(name: "Name ep 5", number: 5, season: 2))

		var episodesViewModelStub = [DetailViewModel.Episode].stub()
		episodesViewModelStub.append(.init(name: "Name ep 5", info: "SE 02 X EP 05"))

		let result = sut.adapt(show: .stub(image: nil, summary: nil), episodes: episodesStub)
		XCTAssertEqual(result, .stub(imageUrl: "", summary: "", episodes: episodesViewModelStub))
	}
}
