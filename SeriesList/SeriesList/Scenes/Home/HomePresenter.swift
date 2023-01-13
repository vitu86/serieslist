//
//  HomePresenter.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

class HomePresenter {

	weak var controller: HomeControllerType?

	private let service: Service
	private let adapter: HomeAdapterType
	private var source: [TVShow] = []

	init(service: Service = .shared,
		 adapter: HomeAdapterType = HomeAdapter()
	) {
		self.service = service
		self.adapter = adapter
	}

	private func adaptAndShow(shows: [TVShow]) {
		source = shows
		controller?.update(list: adapter.adapt(model: source))
	}
}

extension HomePresenter: HomePresenterType {
	func sendToDetail(id: String) {
		guard let show = source.first(where: { String($0.id) == id }) else { return }
		AppCoordinator.shared.route(.detail(show))
	}

	func getShowsList() {
		if service.isFirstPage {
			controller?.showLoading()
		}
		service.getTVShowsList { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case let .success(shows):
					self?.adaptAndShow(shows: shows)

				case .failure:
					self?.controller?.showError()
				}
			}
		}
	}
}
