//
//  Service.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

protocol ServiceType {
	func updateManager(_ requestManager: RequestManagerType)
	func getTVShowsList(page: Int, completion: @escaping (Result<[TVShow], NetworkError>) -> Void)
	func getShowEpisodes(showId: Int64, completion: @escaping (Result<[Episode], NetworkError>) -> Void)
	func searchForShow(with query: String, completion: @escaping (Result<[TVShow], NetworkError>) -> Void)
}

final class Service  {
	// Let's work with some Singleton here.
	static let shared = Service()
	private init() {}

	private var requestManager: RequestManagerType = RequestManager()
	private var hasMorepage = true
	private var isLoading = false
}

extension Service: ServiceType {
	func updateManager(_ requestManager: RequestManagerType) {
		self.requestManager = requestManager
	}

	func getTVShowsList(page: Int, completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
		guard !isLoading && hasMorepage else {
			completion(.success([]))
			return
		}

		isLoading = true

		let endpoint = Endpoints.showsList(page: page)
		requestManager.makeRequest(endpoint) { [weak self] (result: Result<[TVShow], NetworkError>) -> Void in
			if case let .success(showsList) = result {
				self?.hasMorepage = !showsList.isEmpty
			}
			completion(result)
			self?.isLoading = false
		}
	}

	func getShowEpisodes(showId: Int64, completion: @escaping (Result<[Episode], NetworkError>) -> Void) {
		let endpoint = Endpoints.getEpisodies(from: showId)
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
