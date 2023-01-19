//
//  DetailViewSpy.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 19/01/23.
//

import UIKit

@testable import SeriesList

final class DetailViewSpy: BaseView, DetailViewType {
	private(set) var updateCallParam: DetailViewModel?
	func update(show: DetailViewModel) {
		updateCallParam = show
	}
}
