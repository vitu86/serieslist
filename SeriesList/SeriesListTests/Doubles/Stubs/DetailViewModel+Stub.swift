//
//  DetailViewModel+Stub.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

@testable import SeriesList

extension DetailViewModel {
	static func stub(
		name: String = "Name 1",
		imageUrl: String = "ImageUrl",
		genres: String = "action - romance",
		summary: String = "summary",
		episodes: [Episode] = .stub()
	) -> DetailViewModel {
		.init(
			name: name,
			imageUrl: imageUrl,
			genres: genres,
			summary: summary,
			episodes: episodes
		)
	}
}

extension Array where Element == DetailViewModel {
	static func stub() -> [DetailViewModel] {
		(1 ..< 6).map {
			.stub(name: "Name \($0)")
		}
	}
}

extension DetailViewModel.Episode {
	static func stub(name: String = "Name Ep", info: String = "SE1 X EP1") -> DetailViewModel.Episode {
		.init(name: name, info: info)
	}
}

extension Array where Element == DetailViewModel.Episode {
	static func stub() -> [DetailViewModel.Episode] {
		(1 ..< 6).map {
			.stub(name: "Name \($0)", info: "SE1 X EP\($0)")
		}
	}
}

extension DetailViewModel: Equatable {
	public static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
		lhs.name == rhs.name &&
		lhs.episodes == rhs.episodes &&
		lhs.summary == rhs.summary &&
		lhs.genres == rhs.genres &&
		lhs.imageUrl == rhs.imageUrl
	}
}

extension DetailViewModel.Episode: Equatable {
	public static func == (lhs: DetailViewModel.Episode, rhs: DetailViewModel.Episode) -> Bool {
		lhs.name == rhs.name &&
		lhs.info == rhs.info
	}
}
