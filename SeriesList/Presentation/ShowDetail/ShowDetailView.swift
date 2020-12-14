//
//  ShowDetailView.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import TinyConstraints
import UIKit

protocol ShowDetailViewDelegate: AnyObject {
    func showEpisode(_ episode: Episode)
}

class ShowDetailView: BaseView {

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

    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let genres: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let schedule: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let summary: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Detail.episodes
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var episodesList: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    weak var delegate: ShowDetailViewDelegate?

    override init() {
        super.init()
        backgroundColor = .white
        setupUI()
    }

    func update(with show: TVShow, and episodes: [Episode]) {
        if let imageURL = show.image?.original,
            let url = URL(string: imageURL) {
            image.af.setImage(withURL: url)
            image.sizeToFit()
        }

        title.text = show.name

        genres.text = L10n.Detail.genres(show.genres.joined(separator: ", "))

        if let htmlSummary = show.summary?.getHTMLText() {
            summary.attributedText = htmlSummary
        } else {
            summary.text = show.summary
        }

        schedule.text = mountSchedule(with: show.schedule)

        updateEpisodes(with: episodes)
    }

    private func updateEpisodes(with list: [Episode]) {
        var currentSeason: Int64 = 0
        list.forEach { [weak self] episode in
            if episode.season > currentSeason {
                currentSeason = episode.season
                episodesList.addArrangedSubview(
                    EpisodeListTitle(title: L10n.Detail.Episodes.List.session(episode.season))
                )
            }
            episodesList.addArrangedSubview(
                EpisodeListItem(
                    title: episode.name, {
                        self?.delegate?.showEpisode(episode)
                    }
                )
            )
        }
    }

    private func setupUI() {
        addSubview(container)
        container.addSubview(image)
        container.addSubview(title)
        container.addSubview(genres)
        container.addSubview(schedule)
        container.addSubview(summary)
        container.addSubview(episodesLabel)
        container.addSubview(episodesList)

        container.edgesToSuperview(usingSafeArea: true)
        container.width(to: view)
        container.height(to: view, priority: .defaultLow)

        image.edgesToSuperview(excluding: .bottom)
        image.aspectRatio(image.image?.scale ?? 1)
        image.width(to: container, relation: .equal)
        title.horizontalToSuperview(insets: .horizontal(12.0))
        genres.horizontalToSuperview(insets: .horizontal(12.0))
        schedule.horizontalToSuperview(insets: .horizontal(12.0))
        summary.horizontalToSuperview(insets: .horizontal(12.0))
        episodesLabel.horizontalToSuperview(insets: .horizontal(12.0))
        episodesList.edgesToSuperview(excluding: .top, insets: .uniform(12.0))

        title.topToBottom(of: image, offset: 12.0)
        genres.topToBottom(of: title, offset: 6.0)
        schedule.topToBottom(of: genres, offset: 6.0)
        summary.topToBottom(of: schedule, offset: 12.0)
        episodesLabel.topToBottom(of: summary, offset: 12.0)
        episodesList.topToBottom(of: episodesLabel, offset: 6.0)
    }

    private func mountSchedule(with value: Schedule) -> String {
        L10n.Detail.schedule(value.time, value.days.joined(separator: ","))
    }
}
