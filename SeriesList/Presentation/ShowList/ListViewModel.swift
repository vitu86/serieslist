//
//  ListViewModel.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import RxSwift
import XCoordinator

class ListViewModel {

    private let router: WeakRouter<AppRoute>

    init(router: WeakRouter<AppRoute>) {
        self.router = router
    }

    func getTVShowsList() -> Observable<[TVShow]> {
        API.shared.getTVShowsList()
    }

    func triggerToDetail(with show: TVShow) {
        router.trigger(.showDetail(show: show))
    }
}
