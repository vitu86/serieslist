//
//  HomePresenter.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

class HomePresenter {

	weak var controller: HomeController?

	private let service: Service

	init(service: Service = .shared) {
		self.service = service
	}

	func getShowsList() {
		controller?.showLoading()
		service.getTVShowsList { result in
			switch result {
			case let .success(shows):
				print(shows)

			case let .failure(error):
				print(error)
			}
		}
	}
}
