//
//  BeerDataSource.swift
//  Domain
//
//  Created by kusumi on 2021/04/22.
//

import Foundation
import RxSwift

public protocol BeerDataSource {
    func searchBeerList(page: Int) -> Single<Result<Array<Beer>, Error>>
}
