//
//  PictureData.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct PictureData: Codable {
    let hits: [Picture]
}

struct Picture: Codable {
    let largeImageURL: String
}
