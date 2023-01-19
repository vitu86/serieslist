//
//  RequestManagerTests.swift
//  SeriesListTests
//
//  Created by Vitor Costa on 18/01/23.
//


import XCTest
@testable import SeriesList

final class RequestManagerTests: XCTestCase {

	private var sut: RequestManager!
	private var session: CustomSession!

	override func setUpWithError() throws {
		session = CustomSession()
		sut = RequestManager(session: session)
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testNetworkError() {
		// Init with known rawvalue
		let urlError = NetworkError(rawValue: "urlNotFound")
		XCTAssertEqual(urlError, .urlNotFound)

		// Init with unkown value
		let genericError = NetworkError(InternalError())
		XCTAssertEqual(genericError, .generic)
	}

	func testMakeRequestWithURLError() {
		// With url error
		sut.makeRequest(Endpoint(url: "")) {(result: Result<Data, NetworkError>) -> Void in
			if case let .failure(error) = result {
				XCTAssertEqual(error, .urlNotFound)
			} else {
				fatalError()
			}
		}
	}

	func testMakeRequestWithReponseError() {
		// With response error
		session.taskResultError = InternalError()
		sut.makeRequest(Endpoint(url: "http://google.com")) {(result: Result<Data, NetworkError>) -> Void in
			if case let .failure(error) = result {
				XCTAssertEqual(error, .generic)
			} else {
				fatalError()
			}
		}
	}

	func testMakeRequestWithDataError() {
		// With data error
		sut.makeRequest(Endpoint(url: "http://google.com")) {(result: Result<Data, NetworkError>) -> Void in
			if case let .failure(error) = result {
				XCTAssertEqual(error, .missingData)
			} else {
				fatalError()
			}
		}
	}

	func testMakeRequestWithDecodeError() {
		// With decode error
		session.taskResultData = Data()
		sut.makeRequest(Endpoint(url: "http://google.com")) {(result: Result<TVShow, NetworkError>) -> Void in
			if case let .failure(error) = result {
				XCTAssertEqual(error, .decode)
			} else {
				fatalError()
			}
		}
	}

	func testMakeRequestWithSuccess() {
		// With decode error
		let encoder = JSONEncoder()
		session.taskResultData = try? encoder.encode(TVShow.stub())
		sut.makeRequest(Endpoint(url: "http://google.com")) {(result: Result<TVShow, NetworkError>) -> Void in
			if case let .success(success) = result {
				XCTAssertEqual(success, .stub())
			} else {
				fatalError()
			}
		}
	}
}

private struct InternalError: Error {}

private class CustomSession: URLSessionProtocol {
	var taskResultData: Data?
	var taskResltResponse: URLResponse?
	var taskResultError: Error?

	func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		completionHandler(taskResultData, taskResltResponse, taskResultError)
		return URLSession.shared.dataTask(with: url)
	}
}
