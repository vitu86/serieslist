//
//  HomeController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

class HomeController: BaseController {
	private let rootView: HomeViewType
	private let presenter: HomePresenterType

	init(presenter: HomePresenterType, rootView: HomeViewType = HomeView()) {
		self.presenter = presenter
		self.rootView = rootView
		super.init()
	}

	override func loadView() {
		view = rootView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		addActions()
		title = L10n.string(for: "HomeTitle")
		presenter.getShowsList()
	}

	private func addActions() {
		rootView.onClick = { [weak self] item in
			self?.presenter.sendToDetail(id: item.id)
		}

		rootView.onEndReached = { [weak self] in
			self?.presenter.getShowsList()
		}
	}
}

extension HomeController: HomeControllerType {
	func update(list: [HomeViewModel]) {
		rootView.update(list: list)
	}
}
