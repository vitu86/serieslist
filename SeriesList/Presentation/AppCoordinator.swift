//
//  AppCoordinator.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case showList
    case showDetail(show: TVShow)
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .showList)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .showList:
            let viewModel = ListViewModel(router: weakRouter)
            let controller = ListController(viewModel: viewModel)
            return .set([controller])

        case let .showDetail(show):
            let viewModel = ShowDetailViewModel(router: weakRouter, show: show)
            let controller = ShowDetailController(viewModel: viewModel)
            return .push(controller)
        }
    }
}
