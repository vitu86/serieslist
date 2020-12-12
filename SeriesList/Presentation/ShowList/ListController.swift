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
        title = L10n.ListScreen.title
        loadList()
    }

    private func loadList() {
        viewModel.getTVShowsList()
            .catchErrorJustReturn([])
            .bind { [weak self] in
                self?.rootView.update(with: $0)
            }
            .disposed(by: bag)
    }
}

extension ListController: ListViewDelegate {
    func showDetailOfShow(with id: Int64) {
        viewModel.triggerToDetail(with: id)
    }
}
