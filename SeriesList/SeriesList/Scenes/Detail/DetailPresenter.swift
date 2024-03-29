//
//  DetailPresenter.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

import Foundation
import UIKit

final class DetailPresenter {
	private let service: ServiceType
	private let adapter: DetailAdapterType
	private let show: TVShow

	weak var controller: DetailControllerType?

	init(
		service: ServiceType = Service.shared,
		adapter: DetailAdapterType = DetailAdapter(),
		show: TVShow
	) {
		self.service = service
		self.adapter = adapter
		self.show = show
	}

	private func adaptAndShow(episodes: [Episode]) {
		controller?.update(show: adapter.adapt(show: show, episodes: episodes))
	}
}

extension DetailPresenter: DetailPresenterType {
	func getShowDetail() {
		controller?.showLoading()
		service.getShowEpisodes(showId: show.id) { [weak self] result in
			self?.controller?.hideLoading()
			switch result {
			case let .success(episodes):
				self?.adaptAndShow(episodes: episodes)

			case .failure:
				self?.controller?.showError(L10n.string(for: "ErrorDetailFetch")) {
					self?.getShowDetail()
				}
			}
		}
	}
}
