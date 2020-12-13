//
//  EpisodeDetailView.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class EpisodeDetailView: BaseView {

    private let container: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    override init() {
        super.init()
        backgroundColor = .white
        setupUI()
    }

    func update(with episode: Episode) {
        if let imageURL = episode.image?.original,
            let url = URL(string: imageURL) {
            image.af.setImage(withURL: url)
            image.sizeToFit()
        }

        titleLabel.text = episode.name

        descriptionLabel.text = "Season \(episode.season) - Episode: \(episode.number)"

        if let htmlSummary = episode.summary?.getHTMLText() {
            summaryLabel.attributedText = htmlSummary
        } else {
            summaryLabel.text = episode.summary
        }
    }

    private func setupUI() {
        addSubview(container)
        container.addSubview(image)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(summaryLabel)

        container.edgesToSuperview(usingSafeArea: true)
        container.width(to: view)
        container.height(to: view, priority: .defaultLow)

        image.edgesToSuperview(excluding: .bottom)
        image.aspectRatio(image.image?.scale ?? 1)
        image.width(to: container, relation: .equal)
        titleLabel.horizontalToSuperview(insets: .horizontal(12.0))
        descriptionLabel.horizontalToSuperview(insets: .horizontal(12.0))
        summaryLabel.horizontalToSuperview(insets: .horizontal(12.0))

        titleLabel.topToBottom(of: image, offset: 12.0)
        descriptionLabel.topToBottom(of: titleLabel, offset: 6.0)
        summaryLabel.topToBottom(of: descriptionLabel, offset: 12.0)
    }
}
