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

	private let session: URLSessionProtocol

	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}

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

		session.dataTask(with: url) { [weak self] data, _, error in
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

protocol URLSessionProtocol {
	func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
