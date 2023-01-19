//
//  SearchResult+Stub.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 18/01/23.
//

@testable import SeriesList

extension SearchResult {
	static func stub(
		score: Double = 1,
		show: TVShow = .stub()
	) -> SearchResult {
		.init(score: score, show: show)
	}
}

extension Array where Element == SearchResult {
	static func stub() -> [SearchResult] {
		(0 ..< 5).map { .stub(score: Double($0), show: .stub(id: $0, name: "Name \($0)")) }
	}
}
