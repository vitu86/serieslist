//
//  HomeView.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import UIKit

class HomeView: BaseView {

	private var onClick: ((HomeViewModel) -> Void)?

	private lazy var tableHandler = HomeViewTableHandler { [weak self] item in
		self?.onClick?(item)
	}

	private lazy var table: UITableView = {
		let table = UITableView()
		tableHandler.register(table)
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()

	override init() {
		super.init()
		setupUI()
	}

	private func setupUI() {
		addSubview(table)
		addConstraints()
	}

	private func addConstraints() {
		table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		table.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		table.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
}

extension HomeView: HomeViewType {
	func update(list: [HomeViewModel]) {
		hideLoading()
		tableHandler.updateSource(list)
		print("UPDATE VIEW: \(list.count)")
	}
}
