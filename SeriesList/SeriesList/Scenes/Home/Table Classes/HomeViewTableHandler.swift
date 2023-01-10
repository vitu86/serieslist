//
//  HomeViewTableHandler.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/01/23.
//

import UIKit

class HomeViewTableHandler: NSObject {
	private var source: [HomeViewModel] = []
	private var onItemClicked: ((HomeViewModel) -> Void)?
	private let cellIdentifier = "HomeViewTableCell"
	private var tableView: UITableView?

	init(onItemClicked: ((HomeViewModel) -> Void)?) {
		self.onItemClicked = onItemClicked
	}

	func register(_ tableView: UITableView) {
		self.tableView = tableView
		tableView.register(HomeViewTableCell.self, forCellReuseIdentifier: cellIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
	}

	func updateSource(_ newSource: [HomeViewModel]) {
		source = newSource
		tableView?.reloadData()
	}

	deinit {
		tableView = nil
		onItemClicked = nil
	}
}

extension HomeViewTableHandler: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		onItemClicked?(source[indexPath.row])
	}
}

extension HomeViewTableHandler: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		source.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: cellIdentifier,
			for: indexPath
		) as? HomeViewTableCell else {
			fatalError("Could not dequeue HomeViewTableCell")
		}

		cell.bind(to: source[indexPath.row])
		return cell
	}
}
