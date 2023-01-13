//
//  HomeAdapter.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

struct HomeAdapter: HomeAdapterType {
	func adapt(model: [TVShow]) -> [HomeViewModel] {
		model.map {
			.init(
				id: String($0.id),
				name: $0.name,
				imageURL: $0.image?.medium ?? "",
				genres: $0.genres.compactJoin(separator: " - ")
			)
		}
	}
}
