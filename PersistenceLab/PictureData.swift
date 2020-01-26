//
//  PictureData.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

typealias Writable = Codable & Equatable

struct PictureData: Writable {
    let hits: [Picture]
}

struct Picture: Writable {
    let largeImageURL: String
}
