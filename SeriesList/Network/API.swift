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

    func getTVShowsList() -> Observable<[TVShow]> {
        Observable.create { [weak self] observer in
            guard let listShowsURL = self?.listShowsURL else {
                return Disposables.create()
            }

            let request = AF.request(listShowsURL).responseJSON { response in
                switch response.result {
                    case .success:
                        if let data = response.data,
                           let result = try? self?.decoder.decode([TVShow].self, from: data) {
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

}
