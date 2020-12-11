//
//  AppCoordinator.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import XCoordinator

enum AppRoute: Route {
    case list
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .list)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .list:
            let viewModel = ListViewModel(router: weakRouter)
            let controller = ListController(viewModel: viewModel)
            return .set([controller])
        }
    }
}
