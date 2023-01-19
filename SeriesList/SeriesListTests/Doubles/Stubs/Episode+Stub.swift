//
//  Episode+Stub.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 18/01/23.
//

@testable import SeriesList

extension Episode {
	static func stub(
		name: String = "SE1 x EP1",
		number: Int64 = 1,
		season: Int64 = 1
	) -> Episode {
		.init(name: name, number: number, season: season)
	}
}

extension Array where Element == Episode {
	static func stub() -> [Episode] {
		(0 ..< 5).map { .stub(name: "SE1 x EP\($0)", number: $0, season: 1) }
	}
}
