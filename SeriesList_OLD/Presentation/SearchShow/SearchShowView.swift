//
//  SearchShowView.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import TinyConstraints
import UIKit

protocol SearchShowViewDelegate: AnyObject {
    func searchFor(_ query: String)
    func showDetailOfShow(with show: TVShow)
}

class SearchShowView: BaseView {

    private var source: [TVShow] = []

    private lazy var searchTF: UITextField = {
        let stf = UITextField()
        stf.textColor = .black

        stf.backgroundColor = .white
        stf.layer.borderWidth = 1
        stf.layer.cornerRadius = 7

        stf.height(50)

        let paddingView = UIView()
        paddingView.size(CGSize(width: 5, height: 5))

        stf.leftView = paddingView
        stf.rightView = paddingView

        stf.leftViewMode = .always
        stf.rightViewMode = .always

        stf.returnKeyType = .search

        stf.delegate = self

        return stf
    }()

    private lazy var resultList: UITableView = {
        let list = UITableView()
        list.delegate = self
        list.dataSource = self
        list.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        return list
    }()

    weak var delegate: SearchShowViewDelegate?

    override init() {
        super.init()
        setupUI()
    }

    func update(with list: [TVShow]) {
        source = list
        resultList.reloadData()
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(searchTF)
        addSubview(resultList)

        searchTF.edgesToSuperview(excluding: .bottom, insets: .uniform(6.0), usingSafeArea: true)
        resultList.edgesToSuperview(excluding: .top, usingSafeArea: true)

        resultList.topToBottom(of: searchTF, offset: 6.0)

        searchTF.becomeFirstResponder()
    }
}

extension SearchShowView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let query = textField.text {
            delegate?.searchFor(query)
            textField.resignFirstResponder()
        }
        return true
    }
}

extension SearchShowView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)

        cell.bind(to: source[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showDetailOfShow(with: source[indexPath.row])
    }
}

private extension UITableViewCell {
    func bind(to show: TVShow) {
        imageView?.image = nil
        if let imageURL = show.image?.medium, let url = URL(string: imageURL) {
            imageView?.af.setImage(
                withURL: url,
                runImageTransitionIfCached: true,
                completion: { [weak self] _ in
                    self?.layoutSubviews()
                }
            )
        }

        textLabel?.text = show.name
    }
}
