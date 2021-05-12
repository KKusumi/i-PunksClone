//
//  BeerUseCase.swift
//  UseCase
//
//  Created by kusumi on 2021/04/22.
//

import Foundation
import RxSwift
import Domain

public class BeerUseCase {
    
    let repository: BeerRepository
    
    public init(repository: BeerRepository) {
        self.repository = repository
    }
    
    public func fetchBeerList(page: Int) {
        repository.fetchBeerList(page: page)
    }
    
    public func fetchBeerDetail(beerId: Int) {
        repository.fetchBeerDetail(beerId: beerId)
    }
    
    public func observeBeerDetail() -> Observable<Result<Beer, Error>> {
        repository.observeBeerDetail()
    }
    
    public func observeBeerList() -> Observable<Result<Array<Beer>, Error>> {
        repository.observeBeerList()
    }
}
