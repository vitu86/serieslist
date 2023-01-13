//
//  DetailProtocols.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

import UIKit

protocol DetailControllerType: BaseControllerType, AnyObject {
	func update(show: DetailViewModel)
}

protocol DetailViewType: BaseViewType, UIView {
	func update(show: DetailViewModel)
}

protocol DetailAdapterType {
	func adapt(show: TVShow, episodes: [Episode]) -> DetailViewModel
}

protocol DetailPresenterType {
	func getShowDetail()
}
