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
        rootView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.show.name
        rootView.showLoading()
        getEpisodes()
    }

    private func getEpisodes() {
        viewModel.getEpisodesList()
            .catchErrorJustReturn([])
            .bind { [weak self] episodes in
                guard let strongSelf = self else { return }
                let sortedEpisodes = episodes.sorted(by: { $0.season < $1.season })
                strongSelf.rootView.update(with: strongSelf.viewModel.show, and: sortedEpisodes)
                strongSelf.rootView.hideLoading()
            }
            .disposed(by: bag)
    }
}

extension ShowDetailController: ShowDetailViewDelegate {
    func showEpisode(_ episode: Episode) {
        viewModel.triggerEpisode(episode)
    }
}
