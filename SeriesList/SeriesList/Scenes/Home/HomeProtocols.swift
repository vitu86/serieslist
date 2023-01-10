//
//  HomeProtocols.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

protocol HomeControllerType: BaseControllerType, AnyObject {
	func update(list: [HomeViewModel])
}

protocol HomeViewType: BaseViewType, UIView {
	func update(list: [HomeViewModel])
}

protocol HomeAdapterType {
	func adapt(model: [TVShow]) -> [HomeViewModel]
}

protocol HomePresenterType {
	func getShowsList()
}
