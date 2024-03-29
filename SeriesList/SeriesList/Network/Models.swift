//
//  Models.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

struct TVShow: Codable, Equatable {
	let id: Int64
	let name: String
	let image: Image?
	let genres: [String]
	let summary: String?
}

struct Episode: Codable, Equatable {
	let name: String
	let number: Int64
	let season: Int64
}

struct SearchResult: Codable, Equatable {
	let score: Double
	let show: TVShow
}

struct Image: Codable, Equatable {
	let medium: String
	let original: String
}
