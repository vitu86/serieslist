//
//  Episode+Stub.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

@testable import SeriesList

extension Episode {
	static func stub(
		name: String = "Name ep 1",
		number: Int64 = 1,
		season: Int64 = 1
	) -> Episode {
		.init(name: name, number: number, season: season)
	}
}

extension Array where Element == Episode {
	static func stub() -> [Episode] {
		(1 ..< 5).map { .stub(name: "Name ep \($0)", number: $0) }
	}
}
