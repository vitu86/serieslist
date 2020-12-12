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
    private let showId: Int64

    init(router: WeakRouter<AppRoute>, showId: Int64) {
        self.router = router
        self.showId = showId
    }

    func getTVShowDetailst() -> Observable<TVShow> {
        API.shared.getTVShowDetail(with: showId)
    }
}
