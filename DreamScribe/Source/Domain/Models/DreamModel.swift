//
//  DreamModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

struct DreamModel: Codable {
    var id: UUID = .init()
    let date: String
    let description: String
    let tags: [String]
    let type: DreamType
}

enum DreamType: String, Codable {
    case normal = "Normal"
    case nightmare = "Nightmare"
    case lucid = "Lucid"
}
