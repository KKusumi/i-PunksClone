//
//  BeerRepository.swift
//  Domain
//
//  Created by kusumi on 2021/04/22.
//

import Foundation
import RxSwift

public class BeerRepository {
    
    let dataSource: BeerDataSource
    let disposeBag = DisposeBag()
    
    private var beerCache: [Int: Beer] = [:]
    private let beerListSubject = PublishSubject<Result<Array<Beer>, Error>>()
    private let beerDetailSubject = PublishSubject<Result<Beer, Error>>()
    
    public init(dataSource: BeerDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchBeerList(page: Int) {
        dataSource.searchBeerList(page: page).subscribe(on: SerialDispatchQueueScheduler(qos: .default))
            .subscribe(
                onSuccess: { result in
                    switch result {
                    case .success(let beerList):
                        self.cache(beerList: beerList)
                    case .failure(_):
                        break
                    }
                    self.beerListSubject.onNext(result)
                },
                onFailure: { error in
                    self.beerListSubject.onNext(Result.failure(error))
                    
                },
                onDisposed: nil
            ).disposed(by: disposeBag)
    }
    
    public func fetchBeerDetail(beerId: Int) {
        if let beer = beerCache[beerId] {
            beerDetailSubject.onNext(Result.success(beer))
        } else {
            beerDetailSubject.onNext(Result.failure(PunksError.detailError))
        }
    }
    
    public func observeBeerList() -> Observable<Result<Array<Beer>, Error>> {
        return beerListSubject.asObservable()
    }
    
    public func observeBeerDetail() -> Observable<Result<Beer, Error>> {
        return beerDetailSubject.asObservable()
    }
    
    private func cache(beerList: Array<Beer>) {
        beerList.forEach { beer in
            self.beerCache[beer.id] = beer
        }
    }
}
