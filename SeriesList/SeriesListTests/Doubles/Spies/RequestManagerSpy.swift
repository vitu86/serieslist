//
//  RequestManagerSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 17/01/23.
//

@testable import SeriesList

final class RequestManagerSpy: RequestManagerType {

	var errorToReturn: NetworkError?
	var returnEmpty = false

	private(set) var callMakeRequestEndpoint: Endpoint?
	func makeRequest<T: Decodable>(_ endpoint: Endpoint, completion: @escaping RequestResult<T>) {
		callMakeRequestEndpoint = endpoint

		if let errorToReturn = errorToReturn {
			completion(.failure(errorToReturn))
			return
		}

		if let completionTVShow = completion as? RequestResult<[TVShow]> {
			completionTVShow(.success(returnEmpty ? [] : .stub()))
			return
		}

		if let completionSearch = completion as? RequestResult<[SearchResult]> {
			completionSearch(.success(returnEmpty ? [] : .stub()))
			return
		}

		if let completionEpisode = completion as? RequestResult<[Episode]> {
			completionEpisode(.success(returnEmpty ? [] : .stub()))
			return
		}
	}
}
