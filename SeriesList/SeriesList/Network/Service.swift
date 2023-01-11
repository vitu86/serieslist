//
//  Service.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

class Service {
	// Let's work with some Singleton here.
	static let shared = Service()
	private init() {}

	private var requestManager: RequestManagerType = RequestManager()
	private var currentPage = 1
	private var hasMorepage = true
	private var isLoading = false

	func updateManager(_ requestManager: RequestManagerType) {
		self.requestManager = requestManager
	}

	var isFirstPage: Bool { currentPage == 1 }

	func getTVShowsList(completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
		if isLoading || !hasMorepage {
			completion(.success([]))
			return
		}

		isLoading = true

		let endpoint = Endpoints.showsList(page: currentPage)
		requestManager.makeRequest(endpoint) { [weak self] (result: Result<[TVShow], NetworkError>) -> Void in
			if case let .success(showsList) = result {
				self?.currentPage += 1
				self?.hasMorepage = !showsList.isEmpty
			}
			completion(result)
			self?.isLoading = false
		}
	}

	func getShowEpisodes(show: TVShow, completion: @escaping (Result<[Episode], NetworkError>) -> Void) {
		let endpoint = Endpoints.getEpisodies(from: show.id)
		requestManager.makeRequest(endpoint, completion: completion)
	}

	func searchForShow(with query: String, completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
		let endpoint = Endpoints.searchShows(query: query)
		requestManager.makeRequest(endpoint) { (result: Result<[SearchResult], NetworkError>) -> Void in
			switch result {
			case let .success(resultList):
				let convertedList = resultList.map { $0.show }
				completion(.success(convertedList))

			case let .failure(error):
				completion(.failure(error))
			}
		}
	}

}
