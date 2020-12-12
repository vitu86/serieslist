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
        loadDetails()
    }

    private func loadDetails() {
        viewModel.getTVShowDetailst()
            .catchErrorJustReturn(TVShow(id: 0, name: "", image: Image(medium: "", original: "")))
            .bind { [weak self] in
                print($0.name)
                self?.title = $0.name
            }
            .disposed(by: bag)
    }
}
