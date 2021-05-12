//
//  BeerApiService.swift
//  Infra
//
//  Created by kusumi on 2021/04/19.
//

import Foundation
import RxSwift
import Alamofire
import Domain

public class BeerApiService: BeerDataSource {
    
    public init() {}
    
    public func searchBeerList(page: Int) -> Single<Result<Array<Beer>, Error>> {
        return Single<Result<Array<Beer>, Error>>.create { singleEvent in
            let request = AF.request("https://api.punkapi.com/v2/beers",
                method: .get,
                parameters: ["page": page])
                .responseDecodable { (response: DataResponse<[BeerResponse], AFError>) in
                    switch response.result {
                    case .success(let beerResponseList):
                        let beerList = beerResponseList.map({ $0.toBeer() })
                        singleEvent(.success(Result.success(beerList)))
                    case .failure(_):
                        singleEvent(.failure(PunksError.apiError))
                    }
            }
            return Disposables.create {request.cancel()}
//            return Disposables.create { request.cancel() }
        }
    }
}
