//
//  DetailAdapterSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

@testable import SeriesList

final class DetailAdapterSpy: DetailAdapterType {

	var resultAdapt: DetailViewModel?
	private(set) var adaptFirstParam: TVShow?
	private(set) var adaptSecondParam: [Episode]?
	func adapt(show: TVShow, episodes: [Episode]) -> DetailViewModel {
		adaptFirstParam = show
		adaptSecondParam = episodes
		return resultAdapt!
	}
}
