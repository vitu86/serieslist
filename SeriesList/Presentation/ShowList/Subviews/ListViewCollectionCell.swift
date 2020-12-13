//
//  ListViewCollectionCell.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import AlamofireImage
import TinyConstraints
import UIKit

class ListViewCollectionCell: UICollectionViewCell {
    private let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(image)
        contentView.addSubview(title)

        image.edgesToSuperview(excluding: .bottom)
        title.edgesToSuperview(excluding: .top)
        title.topToBottom(of: image, offset: 5.0)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(to show: TVShow) {
        image.image = nil
        if let imageURL = show.image?.medium,
            let url = URL(string: imageURL) {
            image.af.setImage(withURL: url, runImageTransitionIfCached: true)
        }
        title.text = show.name
    }
}
