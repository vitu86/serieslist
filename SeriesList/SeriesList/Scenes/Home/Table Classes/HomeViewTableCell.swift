//
//  HomeViewTableCell.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/01/23.
//

import UIKit

class HomeViewTableCell: UITableViewCell {
	private let container: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private let viewImage: SelfLoadImageView = {
		let imageView = SelfLoadImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		return imageView
	}()

	private let labelName: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.lineBreakMode = .byTruncatingTail
		label.adjustsFontSizeToFitWidth = false
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let labelGenres: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.lineBreakMode = .byTruncatingTail
		label.adjustsFontSizeToFitWidth = false
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI() {
		addSubviews()
		addConstraints()
	}

	private func addSubviews() {
		container.addSubview(viewImage)
		container.addSubview(labelName)
		container.addSubview(labelGenres)
		contentView.addSubview(container)
	}

	private func addConstraints() {
		// Content View
		container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
		container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
		container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
		container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

		// ImageView
		viewImage.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		viewImage.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
		viewImage.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		viewImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
		viewImage.widthAnchor.constraint(equalToConstant: 90).isActive = true

		// Label Name
		labelName.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		labelName.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: 25).isActive = true
		labelName.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true

		// Label Genres
		labelGenres.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10).isActive = true
		labelGenres.leadingAnchor.constraint(equalTo: viewImage.trailingAnchor, constant: 25).isActive = true
		labelGenres.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
	}

	func bind(to model: HomeViewModel) {
		labelName.text = model.name
		labelGenres.text = model.genres
		viewImage.loadImage(model.imageURL)
	}
}
