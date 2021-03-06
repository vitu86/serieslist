//
//  ListView.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

protocol ListViewDelegate: AnyObject {
    func showDetailOfShow(with show: TVShow)
    func loadMore()
}

class ListView: BaseView {

    private var source: [TVShow] = []

    private lazy var list: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(ListViewCollectionCell.self, forCellWithReuseIdentifier: ListViewCollectionCell.description())
        return collection
    }()

    weak var delegate: ListViewDelegate?

    override init() {
        super.init()
        setupUI()
    }

    func update(with shows: [TVShow]) {
        source.append(contentsOf: shows)
        list.reloadData()
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(list)
        list.edgesToSuperview(insets: .horizontal(12), usingSafeArea: true)
    }
}

extension ListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showDetailOfShow(with: source[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        source.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListViewCollectionCell.description(),
            for: indexPath
        ) as? ListViewCollectionCell else {
            fatalError("Couldn't dequeue cell")
        }

        cell.bind(to: source[indexPath.row])

        if indexPath.row >= source.count - 2 {
            delegate?.loadMore()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 60) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
