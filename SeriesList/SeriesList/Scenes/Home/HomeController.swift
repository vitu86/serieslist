//
//  HomeController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

class HomeController: BaseController {
	private let rootView = BaseView()

	override func loadView() {
		view = rootView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = L10n.string(for: "HomeTitle")
	}
}
