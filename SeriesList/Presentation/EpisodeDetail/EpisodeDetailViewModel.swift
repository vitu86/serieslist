//
//  EpisodeDetailViewModel.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import XCoordinator

class EpisodeDetailViewModel {
    private let router: WeakRouter<AppRoute>
    private(set) var episode: Episode

    init(router: WeakRouter<AppRoute>, episode: Episode) {
        self.router = router
        self.episode = episode
    }
}
