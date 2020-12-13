//
//  API.swift
//  SeriesList
//
//  Created by Vitor Costa on 11/12/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Alamofire
import RxSwift

class API {

    enum APIError: Error {
        case decode
        case generic
    }

    static let shared = API()

    private init() {}

    private let decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        return dec
    }()

    private let baseURL = "http://api.tvmaze.com"

    private lazy var listShowsURL = baseURL + "/shows"
    private lazy var searchShowsURL = baseURL + "/search/shows"

    private var currentPage = 0
    private(set) var hasMorepage = true

    func getTVShowsList() -> Observable<[TVShow]> {
        Observable.create { [weak self] observer in
            guard let listShowsURL = self?.listShowsURL else {
                return Disposables.create()
            }

            let request = AF.request(listShowsURL, parameters: ["page": self?.currentPage]).responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data, let result = try? self?.decoder.decode([TVShow].self, from: data) {
                        observer.onNext(result)
                        observer.onCompleted()
                        self?.currentPage += 1
                        self?.hasMorepage = !result.isEmpty
                        return
                    }

                    observer.onError(APIError.decode)

                case .failure:
                    observer.onError(APIError.generic)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    func getEpisodes(from show: TVShow) -> Observable<[Episode]> {
        Observable.create { [weak self] observer in
            guard var listShowsURL = self?.listShowsURL else {
                return Disposables.create()
            }

            listShowsURL += "/\(show.id)/episodes"

            let request = AF.request(listShowsURL).responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data, let result = try? self?.decoder.decode([Episode].self, from: data) {
                        observer.onNext(result)
                        observer.onCompleted()
                        return
                    }

                    observer.onError(APIError.decode)

                case .failure:
                    observer.onError(APIError.generic)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    func searchForShow(with query: String) -> Observable<[TVShow]> {
        Observable.create { [weak self] observer in
            guard let searchShowsURL = self?.searchShowsURL else {
                return Disposables.create()
            }

            let request = AF.request(searchShowsURL, parameters: ["q": query]).responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data, let result = try? self?.decoder.decode([SearchResult].self, from: data) {
                        observer.onNext(
                            result.map {
                                $0.show
                            }
                        )
                        observer.onCompleted()
                        return
                    }

                    observer.onError(APIError.decode)

                case .failure:
                    observer.onError(APIError.generic)
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
