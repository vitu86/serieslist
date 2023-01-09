//
//  ListController.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxCocoa
import RxSwift

class ListController: BaseController {

    private let bag = DisposeBag()
    private let viewModel: ListViewModel
    private lazy var rootView = ListView()

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
        rootView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.List.title
        rootView.showLoading()
        loadList()
        createSearchButton()
    }

    private func createSearchButton() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc private func showSearch() {
        viewModel.triggerSearch()
    }

    private func loadList() {
        viewModel.getTVShowsList()
            .catchErrorJustReturn([])
            .bind { [weak self] in
                self?.rootView.update(with: $0)
                self?.rootView.hideLoading()
            }
            .disposed(by: bag)
    }
}

extension ListController: ListViewDelegate {
    func loadMore() {
        if API.shared.hasMorepage {
            loadList()
        }
    }

    func showDetailOfShow(with show: TVShow) {
        viewModel.triggerToDetail(with: show)
    }
}
