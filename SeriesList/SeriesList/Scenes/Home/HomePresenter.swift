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
	private var currentPage = 1

	init(service: Service = .shared,
		 adapter: HomeAdapterType = HomeAdapter()
	) {
		self.service = service
		self.adapter = adapter
	}

	private func adaptAndShow(shows: [TVShow]) {
		source.append(contentsOf: shows)
		controller?.update(list: adapter.adapt(model: source))
	}
}

extension HomePresenter: HomePresenterType {
	func sendToDetail(id: String) {
		guard let show = source.first(where: { String($0.id) == id }) else { return }
		AppCoordinator.shared.route(.detail(show))
	}

	func getShowsList() {
		if currentPage == 1 {
			controller?.showLoading()
			source = []
		}
		service.getTVShowsList(page: currentPage) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case let .success(shows):
					self?.currentPage += 1
					self?.adaptAndShow(shows: shows)

				case .failure:
					self?.controller?.showError(L10n.string(for: "ErrorShowsFetch")) {
						self?.getShowsList()
					}
				}
			}
		}
	}

	func searchShows(_ query: String) {
		controller?.showLoading()
		source = []
		currentPage = 1
		service.searchForShow(with: query) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case let .success(shows):
					self?.adaptAndShow(shows: shows)

				case .failure:
					self?.controller?.showError(L10n.string(for: "ErrorSearch")) {
						self?.searchShows(query)
					}
				}
			}
		}
	}
}
