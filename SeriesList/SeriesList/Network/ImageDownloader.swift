//
//  ImageDownloader.swift
//  SeriesList
//
//  Created by Vitor Costa on 10/01/23.
//

import UIKit

protocol ImageDownloaderType {
	func downloadImage(path: String, completion: @escaping ImageResult)
}

enum ImageError: String, Error {
	case urlNotFound
	case missingData
	case decode
	case generic

	init(_ error: Error) {
		self = ImageError(rawValue: error.localizedDescription) ?? .generic
	}
}

typealias ImageResult = (Result<UIImage, ImageError>) -> Void

private struct CachedImage {
	let image: UIImage
	let date: Date
}

final class ImageDownloader: ImageDownloaderType {
	private let cacheLimit = 20

	private var imageTasks: [String: URLSessionDataTask] = [:]
	private var imageCaches: [String: CachedImage] = [:]
	private var imageCompletions: [String: [ImageResult]] = [:]

	static let shared = ImageDownloader()
	private init() {}


	func downloadImage(path: String, completion: @escaping ImageResult) {

		guard let url = URL(string: path) else {
			completion(.failure(.urlNotFound))
			return
		}

		if let cacheImage = imageCaches.first(where: { $0.key == url.absoluteString }) {
			completion(.success(cacheImage.value.image))
			return
		}

		if var cacheCompletion = imageCompletions[url.absoluteString] {
			cacheCompletion.append(completion)
			imageCompletions.updateValue(cacheCompletion, forKey: url.absoluteString)
		} else {
			imageCompletions.updateValue([completion], forKey: url.absoluteString)
		}

		if imageTasks[url.absoluteString] != nil {
			return
		}

		let newTask = downloadTask(currentUrl: url)
		newTask.resume()
		imageTasks[url.absoluteString] = newTask

	}

	private func downloadTask(currentUrl: URL) -> URLSessionDataTask {
		URLSession.shared.dataTask(with: currentUrl) { [weak self] data, _, error in

			guard let completions = self?.imageCompletions[currentUrl.absoluteString],
				  !completions.isEmpty else { return }

			if let error = error {
				completions.runCompletion(with: .failure(ImageError(error)))
				return
			}

			guard let data = data else {
				completions.runCompletion(with: .failure(.missingData))
				return
			}

			guard let resultImage = UIImage(data: data) else {
				completions.runCompletion(with: .failure(.decode))
				return
			}

			self?.imageCaches[currentUrl.absoluteString] = CachedImage(image: resultImage, date: .now)
			completions.runCompletion(with: .success(resultImage))
			self?.resetFields(key: currentUrl.absoluteString)
		}
	}

	private func resetFields(key: String) {
		imageTasks.removeValue(forKey: key)
		imageCompletions.removeValue(forKey: key)
		resetImageCache(with: key)
	}

	private func resetImageCache(with key: String) {
		guard imageCaches.count > cacheLimit else { return }

		var oldestCachedImage = imageCaches[key]
		var oldestKeyCached: String = ""

		imageCaches.forEach {
			if $0.value.date < oldestCachedImage?.date ?? .now {
				oldestCachedImage = $0.value
				oldestKeyCached = $0.key
			}
		}
		imageCaches.removeValue(forKey: oldestKeyCached)
	}
}

private extension Array where Element == ImageResult {
	func runCompletion(with result: Result<UIImage, ImageError>) {
		forEach { $0(result) }
	}
}
