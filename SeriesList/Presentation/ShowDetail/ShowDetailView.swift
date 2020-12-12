//
//  ShowDetailView.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import TinyConstraints
import UIKit

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

    override init() {
        super.init()
        backgroundColor = .white
        setupUI()
    }

    func update(with show: TVShow) {
        if let url = URL(string: show.image.original) {
            image.af.setImage(withURL: url)
            image.sizeToFit()
        }

        title.text = show.name

        genres.text = "Genres: \(show.genres.joined(separator: ", "))"

        if let htmlSummary = getHTMLText(for: show.summary) {
            summary.attributedText = htmlSummary
        } else {
            summary.text = show.summary
        }

        schedule.text = mountSchedule(with: show.schedule)
    }

    private func setupUI() {
        addSubview(container)
        container.addSubview(image)
        container.addSubview(title)
        container.addSubview(genres)
        container.addSubview(schedule)
        container.addSubview(summary)

        container.edgesToSuperview(usingSafeArea: true)
        container.width(to: view)
        container.height(to: view, priority: .defaultLow)

        image.edgesToSuperview(excluding: .bottom)
        image.aspectRatio(image.image?.scale ?? 1)
        image.width(to: container, relation: .equal)
        title.horizontalToSuperview(insets: .horizontal(12.0))
        genres.horizontalToSuperview(insets: .horizontal(12.0))
        schedule.horizontalToSuperview(insets: .horizontal(12.0))
        summary.edgesToSuperview(excluding: .top, insets: .uniform(12.0))

        title.topToBottom(of: image, offset: 12.0)
        genres.topToBottom(of: title, offset: 6.0)
        schedule.topToBottom(of: genres, offset: 6.0)
        summary.topToBottom(of: schedule, offset: 12.0)
    }

    private func getHTMLText(for value: String) -> NSAttributedString? {
        guard let valueData = value.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: valueData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }

    private func mountSchedule(with value: Schedule) -> String {
        "At \(value.time), every: \(value.days.joined(separator: ","))"
    }
}
