//
//  RequestManager.swift
//  SeriesList
//
//  Created by Vitor Costa on 09/01/23.
//

import Foundation

enum NetworkError: String, Error {
	case urlNotFound
	case missingData
	case decode
	case generic

	init(_ error: Error) {
		self = NetworkError(rawValue: error.localizedDescription) ?? .generic
	}
}

class RequestManager {

	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()

	func makeRequest<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void){
		guard let url = URL(string: endpoint.url) else {
			completion(.failure(.urlNotFound))
			return
		}

		URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				completion(.failure(NetworkError(error)))
				return
			}

			guard let data = data else {
				completion(.failure(.missingData))
				return
			}

			guard let result = try? self?.decoder.decode(T.self, from: data) else {
				completion(.failure(.decode))
				return
			}

			completion(.success(result))
		}.resume()
	}
}
