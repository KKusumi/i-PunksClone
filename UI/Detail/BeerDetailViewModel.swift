//
//  BeerDetailViewModel.swift
//  UI
//
//  Created by kusumi on 2021/05/02.
//

import Foundation
import UseCase
import RxSwift
import RxCocoa
import Domain

public final class BeerDetailViewModel {
    
    let useCase: BeerUseCase
    
    private let _loadState = BehaviorRelay<LoadState>(value: LoadState.preload)
    lazy var loadState = _loadState.asDriver()
    
    private lazy var _beerDetail: Observable<Beer> = self.useCase.observeBeerDetail()
        .do(
            onNext: { (_) in
                self._loadState.accept(LoadState.complete)
            },
            afterNext: nil,
            onError: { (_) in
                self._loadState.accept(LoadState.error)
            },
            afterError: nil,
            onCompleted: nil,
            afterCompleted: nil,
            onSubscribe: nil,
            onSubscribed: nil,
            onDispose: nil
        )
        .map { result in
            switch result {
            case .success(let beerDetail):
                return beerDetail
            case .failure(let error):
                throw error
            }
        }
    
    lazy var beerImageUrl: Driver<String> =
        _beerDetail.map { $0.imageUrl! }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var beerName: Driver<String> =
        _beerDetail.map { $0.name }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var tagline: Driver<String> =
        _beerDetail.map { $0.tagline }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var abv: Driver<String> =
        _beerDetail.map { $0.abv }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var ibu: Driver<String> =
        _beerDetail.map { $0.ibu }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var og: Driver<String> =
        _beerDetail.map { $0.targetOg }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var description: Driver<String> =
        _beerDetail.map { $0.description }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var foodPairing: Driver<String> =
        _beerDetail.map { $0.foodPairing.joined(separator: "\n") }.asDriver(onErrorDriveWith: Driver.empty())
    lazy var brewersTips: Driver<String> =
        _beerDetail.map { $0.brewersTips }.asDriver(onErrorDriveWith: Driver.empty())
    
    public init(useCase: BeerUseCase) {
        self.useCase = useCase
    }
    
    func fetchBeerDetail(beerId: Int) {
        useCase.fetchBeerDetail(beerId: beerId)
    }
}
