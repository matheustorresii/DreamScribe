//
//  DreamModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

struct DreamModel: Codable {
    let id: UUID = .init()
    let date: String
    let description: String
    let tags: [String]
    let type: DreamType
}

enum DreamType: String, Codable {
    case normal
    case nightmare
    case lucid
}
