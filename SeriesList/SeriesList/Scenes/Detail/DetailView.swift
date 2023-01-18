//
//  DetailView.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/01/23.
//

import UIKit

final class DetailView: BaseView {
	private let scroll: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		return scroll
	}()

	private let scrollContent: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private let imageView: SelfLoadImageView = {
		let view = SelfLoadImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFill
		view.clipsToBounds = true
		return view
	}()

	private let labelName: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.numberOfLines = 1
		label.lineBreakMode = .byTruncatingTail
		label.adjustsFontSizeToFitWidth = false
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let labelGenres: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 15)
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = false
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let labelSummary: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 17)
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = false
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let episodesStack: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.spacing = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init() {
		super.init()
		setupUI()
	}

	private func setupUI() {
		addSubviews()
		addConstraints()
	}

	private func addSubviews() {
		scrollContent.addSubview(imageView)
		scrollContent.addSubview(labelName)
		scrollContent.addSubview(labelGenres)
		scrollContent.addSubview(labelSummary)
		scrollContent.addSubview(episodesStack)
		scroll.addSubview(scrollContent)
		addSubview(scroll)
	}

	private func addConstraints() {
		// Scroll
		scroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		scroll.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
		scroll.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

		// Scroll Content
		scrollContent.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
		scrollContent.trailingAnchor.constraint(equalTo: scroll.trailingAnchor).isActive = true
		scrollContent.leadingAnchor.constraint(equalTo: scroll.leadingAnchor).isActive = true
		scrollContent.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
		scrollContent.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
		scrollContent.heightAnchor.constraint(greaterThanOrEqualTo: scroll.heightAnchor).isActive = true

		// ImageView
		imageView.topAnchor.constraint(equalTo: scrollContent.topAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor).isActive = true
		imageView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true

		// Name
		labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
		labelName.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16).isActive = true
		labelName.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16).isActive = true

		// Genres
		labelGenres.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10).isActive = true
		labelGenres.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16).isActive = true
		labelGenres.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16).isActive = true

		// Summary
		labelSummary.topAnchor.constraint(equalTo: labelGenres.bottomAnchor, constant: 10).isActive = true
		labelSummary.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16).isActive = true
		labelSummary.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16).isActive = true

		// Episodes Stack
		episodesStack.topAnchor.constraint(equalTo: labelSummary.bottomAnchor, constant: 25).isActive = true
		episodesStack.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -16).isActive = true
		episodesStack.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 16).isActive = true
		episodesStack.bottomAnchor.constraint(lessThanOrEqualTo: scrollContent.bottomAnchor).isActive = true

	}

	private func addEpisodes(_ episodes: [DetailViewModel.Episode]) {
		episodes.forEach {
			let label = UILabel()
			label.text = "\($0.info): \($0.name)"
			label.lineBreakMode = .byTruncatingTail
			episodesStack.addArrangedSubview(label)
		}
	}

}

extension DetailView: DetailViewType {
	func update(show: DetailViewModel) {
		imageView.loadImage(show.imageUrl)
		labelName.text = show.name
		labelGenres.text = show.genres
		labelSummary.text = show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
		addEpisodes(show.episodes)
	}
}
