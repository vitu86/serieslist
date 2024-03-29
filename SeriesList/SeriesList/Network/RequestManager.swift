//
//  RequestManager.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

protocol RequestManagerType {
	func makeRequest<T: Decodable>(_ endpoint: Endpoint, completion: @escaping RequestResult<T>)
}

typealias RequestResult<T> = (Result<T, NetworkError>) -> Void

enum NetworkError: String, Error {
	case urlNotFound
	case missingData
	case decode
	case generic

	init(_ error: Error) {
		self = NetworkError(rawValue: error.localizedDescription) ?? .generic
	}
}

final class RequestManager: RequestManagerType {
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()

	func makeRequest<T: Decodable>(_ endpoint: Endpoint, completion: @escaping RequestResult<T>){
		guard let url = URL(string: endpoint.url) else {
			completion(.failure(.urlNotFound))
			return
		}

		URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				DispatchQueue.main.async {
					completion(.failure(NetworkError(error)))
				}
				return
			}

			guard let data = data else {
				DispatchQueue.main.async {
					completion(.failure(.missingData))
				}
				return
			}

			guard let result = try? self?.decoder.decode(T.self, from: data) else {
				DispatchQueue.main.async {
					completion(.failure(.decode))
				}
				return
			}
			DispatchQueue.main.async {
				completion(.success(result))
			}
		}.resume()
	}
}
