//
//  BaseClass.swift
//  PitchPerfect
//
//  Created by Vitor Costa on 21/07/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}

class BaseView: UIView {
    private lazy var loadingView = Loading()

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showLoading() {
        addSubview(loadingView)
        loadingView.edgesToSuperview()
        bringSubviewToFront(loadingView)
    }

    func hideLoading() {
        loadingView.removeFromSuperview()
    }
}

private class Loading: UIView {

    private let loadingIndicator = UIActivityIndicatorView(style: .gray)

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white
        addSubview(loadingIndicator)
        loadingIndicator.edgesToSuperview()
        loadingIndicator.startAnimating()
    }
}
