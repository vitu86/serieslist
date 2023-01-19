//
//  TVShow+Stub.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 18/01/23.
//

@testable import SeriesList

extension TVShow {
	static func stub(
		id: Int64 = 1,
		name: String = "Name 1",
		image: Image? = .stub(),
		genres: [String] = ["action", "romance"],
		summary: String? = "summary"
	) -> TVShow {
		.init(id: id, name: name, image: image, genres: genres, summary: summary)
	}
}

extension Array where Element == TVShow {
	static func stub() -> [TVShow] {
		(1 ..< 5).map { .stub(id: $0, name: "Name \($0)") }
	}
}

extension Image {
	static func stub(medium: String = "medium url", original: String = "original url") -> Image {
		.init(medium: medium, original: original)
	}
}
