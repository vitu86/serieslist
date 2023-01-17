//
//  BaseProtocols.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

protocol BaseControllerType {
	func showLoading()
	func hideLoading()
	func showError(_ message: String, tryAgainFunction: (() -> Void)?)
}

protocol BaseViewType {
	func showLoading()
	func hideLoading()
}
