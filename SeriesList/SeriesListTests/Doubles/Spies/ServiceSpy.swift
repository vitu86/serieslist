//
//  ServiceSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

@testable import SeriesList

final class ServiceSpy: ServiceType {

	var mockResultGetTVShowsList: Result<[TVShow], NetworkError>?
	private(set) var getTVShowsListParam: Int?
	func getTVShowsList(page: Int, completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
		getTVShowsListParam = page
		completion(mockResultGetTVShowsList!)
	}

	var mockResultGetShowEpisodes: Result<[Episode], NetworkError>?
	private(set) var getShowEpisodesParam: Int64?
	func getShowEpisodes(showId: Int64, completion: @escaping (Result<[Episode], NetworkError>) -> Void) {
		getShowEpisodesParam = showId
		completion(mockResultGetShowEpisodes!)
	}

	var mockResultSearchForShow: Result<[TVShow], NetworkError>?
	private(set) var searchForShowParam: String?
	func searchForShow(with query: String, completion: @escaping (Result<[TVShow], NetworkError>) -> Void) {
		searchForShowParam = query
		completion(mockResultSearchForShow!)
	}
	
}
