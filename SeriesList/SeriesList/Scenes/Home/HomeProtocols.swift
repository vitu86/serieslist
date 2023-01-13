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
	var onClick: ((HomeViewModel) -> Void)? { get set }
	var onEndReached: (() -> Void)? { get set }
	func update(list: [HomeViewModel])
}

protocol HomeAdapterType {
	func adapt(model: [TVShow]) -> [HomeViewModel]
}

protocol HomePresenterType {
	func getShowsList()
	func sendToDetail(id: String)
}
