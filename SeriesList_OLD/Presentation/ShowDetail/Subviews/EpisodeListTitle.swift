//
//  EpisodeListTitle.swift
//  SeriesList
//
//  Created by Vitor Costa on 12/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class EpisodeListTitle: BaseView {
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0)
        return label
    }()

    init(title: String) {
        super.init()
        self.title.text = title
        setupUI()
    }

    private func setupUI() {
        addSubview(title)
        title.edgesToSuperview(insets: .uniform(12.0))

        backgroundColor = .lightGray
    }
}
