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
	private var onEndReached: (() -> Void)?
	private let cellIdentifier = "HomeViewTableCell"
	private var tableView: UITableView?

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .medium)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var loadingContainer: UIView = {
		let view = UIView(frame: .init(origin: .zero, size: .init(width: 40, height: 100)))
		view.addSubview(activityIndicator)
		activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		activityIndicator.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 40).isActive = true
		activityIndicator.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -40).isActive = true
		return view
	}()

	init(
		onItemClicked: ((HomeViewModel) -> Void)?,
		onEndReached: (() -> Void)?
	) {
		self.onItemClicked = onItemClicked
		self.onEndReached = onEndReached
	}

	func register(_ tableView: UITableView) {
		tableView.rowHeight = 135
		tableView.register(HomeViewTableCell.self, forCellReuseIdentifier: cellIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
		self.tableView = tableView
	}

	func updateSource(_ newSource: [HomeViewModel]) {
		tableView?.tableFooterView = nil
		if newSource.isEmpty {return }
		source.append(contentsOf: newSource)
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

		if indexPath.row >= source.count - 2, tableView.tableFooterView?.isHidden ?? true {
			onEndReached?()
			tableView.tableFooterView = loadingContainer
			tableView.tableFooterView?.isHidden = false
			activityIndicator.startAnimating()
		}

		return cell
	}
}
