//
//  Models.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

struct TVShow: Decodable {
	let id: Int64
	let name: String
	let image: Image?
	let genres: [String]
	let summary: String?
}

struct Episode: Decodable {
	let name: String
	let number: Int64
	let season: Int64
}

struct SearchResult: Decodable {
	let score: Double
	let show: TVShow
}

struct Image: Decodable {
	let medium: String
	let original: String
}
