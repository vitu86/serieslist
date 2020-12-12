//
//  ShowDetailController.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxCocoa
import RxSwift

class ShowDetailController: BaseController {

    private let bag = DisposeBag()
    private let viewModel: ShowDetailViewModel
    private lazy var rootView = ShowDetailView()

    init(viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.show.name
        rootView.update(with: viewModel.show)
        getEpisodes()
    }

    private func getEpisodes() {
        viewModel.getEpisodesList()
            .catchErrorJustReturn([])
            .bind { [weak self] in
                self?.rootView.updateEpisodes(with: $0)
            }
            .disposed(by: bag)
    }
}
