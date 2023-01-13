//
//  DetailAdapter.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

struct DetailAdapter: DetailAdapterType {
	func adapt(show: TVShow, episodes: [Episode]) -> DetailViewModel {
		let vmEpisodes = episodes
			.sorted {
				if $0.season != $1.season {
					return $0.season < $1.season
				}
				return $0.number < $1.number
			}
			.map {
				let seasonStringCount = String($0.season).count
				let season = String(repeating: "0", count: (2 - seasonStringCount)) + String($0.season)

				let numberStringCount = String($0.number).count
				let number = String(repeating: "0", count: (2 - numberStringCount)) + String($0.number)

				let epInfo = "SE \(season) X EP \(number)"
				return DetailViewModel.Episode(name: $0.name, info: epInfo)
			}
		return DetailViewModel(
			name: show.name,
			imageUrl: show.image?.original ?? "",
			genres: show.genres.compactJoin(separator: " - "),
			summary: show.summary ?? "",
			episodes: vmEpisodes
		)
	}
}
