//
//  TVShow.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

struct TVShow: Decodable {
    let id: Int64
    let name: String
    let image: Image
    let genres: [String]
    let summary: String
    let schedule: Schedule
}

struct Image: Decodable {
    let medium: String
    let original: String
}

struct Schedule: Decodable {
    let time: String
    let days: [String]
}