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

class ImageDownloader: ImageDownloaderType {
	private let cacheLimit = 20

	private var imageTasks: [String: URLSessionDataTask] = [:]
	private var imageCaches: [String: UIImage] = [:]
	private var imageCompletions: [String: [ImageResult]] = [:]

	static let shared = ImageDownloader()
	private init() {}


	func downloadImage(path: String, completion: @escaping ImageResult) {

		guard let url = URL(string: path) else {
			completion(.failure(.urlNotFound))
			return
		}

		if let cacheImage = imageCaches[url.absoluteString] {
			completion(.success(cacheImage))
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

			self?.imageCaches[currentUrl.absoluteString] = resultImage
			completions.runCompletion(with: .success(resultImage))
		}
	}

	private func resetFields(key: String) {
		imageTasks.removeValue(forKey: key)
		imageCompletions.removeValue(forKey: key)

		if imageCaches.count > cacheLimit {
			print("DEBUG PRINT. ANTES: \(imageCaches.count)")
			_ = imageCaches.popFirst()
			print("DEBUG PRINT. ANTES: \(imageCaches.count)")
		}
	}
}

private extension Array where Element == ImageResult {
	func runCompletion(with result: Result<UIImage, ImageError>) {
		forEach { $0(result) }
	}
}
