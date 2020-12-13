//
//  SearchShowViewModel.swift
//  SeriesList
//
//  Created by Vitor Costa on 13/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxSwift
import XCoordinator

class SearchShowViewModel {
    private let router: WeakRouter<AppRoute>

    init(router: WeakRouter<AppRoute>) {
        self.router = router
    }

    func getShows(with query: String) -> Observable<[TVShow]> {
        API.shared.searchForShow(with: query)
    }

    func triggerDetails(of show: TVShow) {
        router.trigger(.showDetail(show: show))
    }
}
