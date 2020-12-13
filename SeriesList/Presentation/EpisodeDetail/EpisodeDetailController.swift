//
//  EpisodeDetailController.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

class EpisodeDetailController: BaseController {
    private let rootView = EpisodeDetailView()
    private let viewModel: EpisodeDetailViewModel

    init(viewModel: EpisodeDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.episode.name
        rootView.update(with: viewModel.episode)
    }
}
