//
//  Beer.swift
//  Domain
//
//  Created by kusumi on 2021/04/22.
//

import Foundation

public struct Beer {
    public let id: Int
    public let name: String
    public let tagline: String
    public let firstBrewed: String
    public let description: String
    public let imageUrl: String?
    public let abv: String
    public let ibu: String
    public let targetOg: String
    let targetFg: String
    let ebc: String
    let srm: String
    let volume: String
    let boilVolume: String
    let ph: String
    let attenuationLevel: String
    public let foodPairing: [String]
    public let brewersTips: String
    
    public init(
        id: Int,
        name: String,
        tagline: String,
        firstBrewed: String,
        description: String,
        imageUrl: String,
        abv: String,
        ibu: String,
        targetOg: String,
        targetFg: String,
        ebc: String,
        srm: String,
        volume: String,
        boilVolume: String,
        ph: String,
        attenuationLevel: String,
        foodPairing: [String],
        brewersTips: String
    ) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.description = description
        self.imageUrl = imageUrl
        self.abv = abv
        self.ibu = ibu
        self.targetOg = targetOg
        self.targetFg = targetFg
        self.ebc = ebc
        self.srm = srm
        self.volume = volume
        self.boilVolume = boilVolume
        self.ph = ph
        self.attenuationLevel = attenuationLevel
        self.foodPairing = foodPairing
        self.brewersTips = brewersTips
    }
}
