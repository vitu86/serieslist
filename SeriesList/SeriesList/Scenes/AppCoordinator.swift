//
//  AppCoordinator.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

enum Route {
	case home
}

struct AppCoordinator {

	private(set) var initialRout: Route
	private let navigation: UINavigationController

	init(initialRout: Route = .home, navigation: UINavigationController) {
		self.initialRout = initialRout
		self.navigation = navigation
		route(initialRout)
	}

	func route(_ to: Route) {
		switch to {
		case .home:
			routeToHome()
		}
	}

}

// MARK: - Builders
extension AppCoordinator {
	private func routeToHome() {
		let presenter = HomePresenter()
		let viewController = HomeController(presenter: presenter)

		presenter.controller = viewController

		navigation.viewControllers = [viewController]
	}
}
