//
//  EpisodeListItem.swift
//  SeriesList
//
//  Created by Vitor Costa on 12/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class EpisodeListItem: BaseView {
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    private let chevron: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.font = .boldSystemFont(ofSize: 11.0)
        return label
    }()

    typealias ListItemClick = () -> Void

    private let onTap: ListItemClick

    init(title: String, _ onTap: @escaping ListItemClick) {
        self.onTap = onTap
        super.init()
        self.title.text = title
        setupUI()
        addGesture()
    }

    private func setupUI() {
        addSubview(title)
        addSubview(chevron)

        title.verticalToSuperview(insets: .vertical(12.0))
        chevron.centerYToSuperview()

        title.leftToSuperview()
        chevron.rightToSuperview(offset: -6.0)
    }

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        addGestureRecognizer(tapGesture)
    }

    @objc private func onClick() {
        onTap()
    }
}
