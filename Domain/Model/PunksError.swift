//
//  PunksError.swift
//  Domain
//
//  Created by kusumi on 2021/04/22.
//

import Foundation

public enum PunksError: String, Error {
    case apiError = "API error"
    case detailError = "Invalid beerId"
}
