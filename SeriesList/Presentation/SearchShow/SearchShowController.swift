//
//  SearchShowController.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxSwift
import UIKit

class SearchShowController: BaseController {
    private lazy var rootView = SearchShowView()
    private let viewModel: SearchShowViewModel
    private let bag = DisposeBag()

    init(viewModel: SearchShowViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
        rootView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        rootView.showLoading()
    }

    private func search(_ query: String) {
        viewModel.getShows(with: query)
            .catchErrorJustReturn([])
            .bind { [weak self] in
                self?.rootView.update(with: $0)
                self?.rootView.hideLoading()
            }
            .disposed(by: bag)
    }
}

extension SearchShowController: SearchShowViewDelegate {
    func showDetailOfShow(with show: TVShow) {
        viewModel.triggerDetails(of: show)
    }

    func searchFor(_ query: String) {
        search(query)
    }

}
