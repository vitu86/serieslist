//
//  ShowDetailViewModel.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxSwift
import XCoordinator

class ShowDetailViewModel {

    private let router: WeakRouter<AppRoute>
    private(set) var show: TVShow

    init(router: WeakRouter<AppRoute>, show: TVShow) {
        self.router = router
        self.show = show
    }

    func getEpisodesList() -> Observable<[Episode]> {
        API.shared.getEpisodes(from: show)
    }

    func triggerEpisode(_ episode: Episode) {
        router.trigger(.showEpisode(episode: episode))
    }
}
