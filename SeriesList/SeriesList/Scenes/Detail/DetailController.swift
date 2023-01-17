//
//  DetailController.swift
//  SeriesList
//
//  Created by Vitor Costa on 12/01/23.
//

import UIKit

final class DetailController: BaseController {
	private let rootView: DetailViewType
	private let presenter: DetailPresenterType

	init(rootView: DetailViewType = DetailView(), presenter: DetailPresenterType) {
		self.rootView = rootView
		self.presenter = presenter
		super.init()
	}

	override func loadView() {
		view = rootView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.getShowDetail()
	}
}

extension DetailController: DetailControllerType {
	func update(show: DetailViewModel) {
		title = show.name
		rootView.update(show: show)
	}
}
