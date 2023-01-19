//
//  DetailPresenterSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

@testable import SeriesList

final class DetailPresenterSpy: DetailPresenterType {
	private(set) var getShowDetailCallCount = 0
	func getShowDetail() {
		getShowDetailCallCount += 1
	}
}
