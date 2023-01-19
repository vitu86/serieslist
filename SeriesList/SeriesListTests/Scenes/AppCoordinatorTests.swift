//
//  AppCoordinatorTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import XCTest
@testable import SeriesList

final class AppCoordinatorTests: XCTestCase {
	var navigation: UINavigationController!

	override func setUpWithError() throws {
		navigation = UINavigationController()
		AppCoordinator.shared.navigation = navigation
	}

	override func tearDownWithError() throws {
		navigation = nil
	}

	func testRouteToHome() {
		// Route to home
		AppCoordinator.shared.route(.home)
		let resultHome = navigation.topViewController is HomeController
		XCTAssertTrue(resultHome)
	}

	func testRouteToDetail() {
		// Route to detail
		AppCoordinator.shared.route(.detail(.stub()))
		let resultDetail = navigation.topViewController is DetailController
		XCTAssertTrue(resultDetail)
	}
}
