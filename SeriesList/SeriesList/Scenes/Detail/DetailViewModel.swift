//
//  DetailViewModel.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

struct DetailViewModel {
	let name: String
	let imageUrl: String
	let genres: String
	let summary: String
	let episodes: [Episode]

	struct Episode {
		let name: String
		let info: String
	}
}
