//
//  Endpoints.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

struct Endpoint {
	let url: String
	let params: [String: Any]
}

struct Endpoints {

	private static let baseURL = "http://api.tvmaze.com"

	static func showsList(page: Int = 1) -> Endpoint {
		Endpoint(
			url: baseURL + "/shows",
			params: ["page": page]
		)
	}

	static func getEpisodies(from tvShowId: Int64) -> Endpoint {
		Endpoint(
			url: baseURL + "/shows\(tvShowId)/episodes",
			params: [:]
		)
	}

	static func searchShows(query: String = "") -> Endpoint {
		Endpoint(
			url: baseURL + "/search/shows",
			params: ["q": query]
		)
	}
}
