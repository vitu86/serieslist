//
//  SelfLoadImageView.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/01/23.
//

import Foundation
import UIKit

class SelfLoadImageView: UIImageView {
	private var imageUrl: String = ""

	private lazy var loadingView: LoadingView = {
		let view = LoadingView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	func loadImage(_ imageUrl: String, downloader: ImageDownloaderType = ImageDownloader.shared) {
		self.imageUrl = imageUrl
		showLoading()
		downloader.downloadImage(path: imageUrl) { [weak self] result in
			guard let currentImageUrl = self?.imageUrl,
				  currentImageUrl == imageUrl else { return }

			DispatchQueue.main.async {
				switch result {
				case let .success(image):
					self?.image = image

				case .failure:
					self?.image = Images.get(for: "--")
				}
				self?.hideLoading()
			}
		}
	}
}

// MARK: - Loading Functions
extension SelfLoadImageView {
	private func showLoading() {
		addSubview(loadingView)
		loadingView.animate()
		addLoadingConstraints()
		bringSubviewToFront(loadingView)
	}

	private func hideLoading() {
		loadingView.removeFromSuperview()
	}

	private func addLoadingConstraints() {
		loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
		loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
		loadingView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
		loadingView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
}
