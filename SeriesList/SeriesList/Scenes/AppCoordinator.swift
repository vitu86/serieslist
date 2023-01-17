//
//  AppCoordinator.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

enum Route {
	case home
	case detail(_ show: TVShow)
}

final class AppCoordinator {
	var navigation: UINavigationController? {
		didSet {
			route(.home)
		}
	}

	static let shared = AppCoordinator()
	private init() {}

	func route(_ to: Route) {
		switch to {
		case .home:
			routeToHome()

		case let .detail(show):
			routeToDetail(show)
		}
	}

}

// MARK: - Builders
extension AppCoordinator {
	private func routeToHome() {
		let presenter = HomePresenter()
		let viewController = HomeController(presenter: presenter)

		presenter.controller = viewController

		navigation?.viewControllers = [viewController]
	}

	private func routeToDetail(_ show: TVShow) {
		let presenter = DetailPresenter(show: show)
		let viewController = DetailController(presenter: presenter)

		presenter.controller = viewController

		navigation?.pushViewController(viewController, animated: true)
	}
}
