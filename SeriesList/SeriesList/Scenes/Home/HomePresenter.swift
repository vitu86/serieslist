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

	init(service: Service = .shared, adapter: HomeAdapterType = HomeAdapter()) {
		self.service = service
		self.adapter = adapter
	}

}

extension HomePresenter: HomePresenterType {
	func getShowsList() {
		controller?.showLoading()
		service.getTVShowsList { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case let .success(shows):
					self?.controller?.update(list: self?.adapter.adapt(model: shows) ?? [])

				case .failure:
					self?.controller?.showError()
				}
			}
		}
	}
}
