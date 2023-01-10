//
//  HomeController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

class HomeController: BaseController {
	private let rootView: HomeViewType = HomeView()
	private let presenter: HomePresenterType

	init(presenter: HomePresenterType) {
		self.presenter = presenter
		super.init()
	}

	override func loadView() {
		view = rootView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = L10n.string(for: "HomeTitle")
		presenter.getShowsList()
	}
}

extension HomeController: HomeControllerType {
	func update(list: [HomeViewModel]) {
		rootView.update(list: list)
	}
}
