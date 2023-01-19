//
//  ServiceTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 17/01/23.
//

import XCTest
@testable import SeriesList

final class ServiceTests: XCTestCase {

	var requestManagerSpy: RequestManagerSpy!

	override func setUpWithError() throws {
		requestManagerSpy = RequestManagerSpy()
		Service.shared.updateManager(requestManagerSpy)
	}

	override func tearDownWithError() throws {
		requestManagerSpy = nil
	}

	func testGetTVShowsList() {
		Service.shared.getTVShowsList(page: 1) {
			if case let .success(result) = $0 {
				XCTAssertEqual(result, .stub())
			}
		}

		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.showsList())

		// Simulate am empty response from requestmanager
		requestManagerSpy.returnEmpty = true
		Service.shared.getTVShowsList(page: 1) { _ in }

		// When has no more pages
		requestManagerSpy.returnEmpty = false
		Service.shared.getTVShowsList(page: 1) {
			if case let .success(result) = $0 {
				XCTAssertEqual(result, [])
			}
		}

		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.showsList())
	}

	func testGetShowEpisodes() {
		Service.shared.getShowEpisodes(showId: 1) {
			if case let .success(result) = $0 {
				XCTAssertEqual(result, .stub())
			}
		}

		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.getEpisodies(from: 1))
	}

	func testSearchForShowt() {
		// With filled param
		Service.shared.searchForShow(with: "query") {
			if case let .success(result) = $0 {
				XCTAssertEqual(result, .stub())
			}
		}
		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.searchShows(query: "query"))

		// With empty param
		Service.shared.searchForShow(with: "") {
			if case let .success(result) = $0 {
				XCTAssertEqual(result, .stub())
			}
		}
		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.searchShows(query: ""))

		// With error
		requestManagerSpy.errorToReturn = .generic
		Service.shared.searchForShow(with: "") {
			if case let .failure(error) = $0 {
				XCTAssertEqual(error, .generic)
			}
		}
		XCTAssertEqual(requestManagerSpy.callMakeRequestEndpoint, Endpoints.searchShows(query: ""))

	}
}
