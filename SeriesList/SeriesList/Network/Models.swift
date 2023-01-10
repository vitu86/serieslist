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
	let schedule: Schedule
}

struct Episode: Decodable {
	let id: Int64
	let name: String
	let number: Int64
	let season: Int64
	let summary: String?
	let image: Image?
}

struct SearchResult: Decodable {
	let score: Double
	let show: TVShow
}

struct Image: Decodable {
	let medium: String
	let original: String
}

struct Schedule: Decodable {
	let time: String
	let days: [String]
}
