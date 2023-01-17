//
//  HomeController.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation
import UIKit

final class HomeController: BaseController {
	private var searchQuery: String?
	private let rootView: HomeViewType
	private let presenter: HomePresenterType

	private lazy var resetButton: UIBarButtonItem = {
		let button = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(onResetButtonClicked)
		)
		return button
	}()

	private lazy var searchButton: UIBarButtonItem = {
		let button = UIBarButtonItem(
			barButtonSystemItem: .search,
			target: self,
			action: #selector(onSearchButtonClicked)
		)
		return button
	}()

	private lazy var searchBar: UISearchBar = {
		let view = UISearchBar()
		view.searchBarStyle = .minimal
		view.showsCancelButton = true
		view.delegate = self
		return view
	}()

	init(presenter: HomePresenterType, rootView: HomeViewType = HomeView()) {
		self.presenter = presenter
		self.rootView = rootView
		super.init()
	}

	override func loadView() {
		view = rootView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		addActions()
		resetNavBar()
		presenter.getShowsList()
	}

	private func addActions() {
		rootView.onClick = { [weak self] item in
			self?.presenter.sendToDetail(id: item.id)
		}

		rootView.onEndReached = { [weak self] in
			self?.onEndReached()
		}
	}

	private func onEndReached() {
		if searchQuery == nil {
			presenter.getShowsList()
		} else {
			rootView.update(list: [])
		}
	}

	private func showSearchBar() {
		navigationItem.titleView = searchBar
		navigationItem.rightBarButtonItem = nil
		searchBar.becomeFirstResponder()
	}

	private func resetNavBar() {
		searchBar.resignFirstResponder()
		navigationItem.titleView = nil

		if let searchQuery = searchQuery {
			navigationItem.title = L10n.string(for: "HomeTitleForResult").appending(searchQuery)
			navigationItem.rightBarButtonItem = resetButton
		} else {
			navigationItem.title = L10n.string(for: "HomeTitle")
			navigationItem.rightBarButtonItem = searchButton
		}
	}

	@objc
	private func onSearchButtonClicked() {
		showSearchBar()
	}

	@objc
	private func onResetButtonClicked() {
		searchQuery = nil
		resetNavBar()
		presenter.getShowsList()
	}
}

extension HomeController: HomeControllerType {
	func update(list: [HomeViewModel]) {
		rootView.update(list: list)
	}
}

extension HomeController: UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		resetNavBar()
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let searchText = (searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
		guard !searchText.isEmpty else {
			searchQuery = nil
			presenter.getShowsList()
			return
		}
		searchQuery = searchText
		presenter.searchShows(searchText)
		resetNavBar()
	}
}
