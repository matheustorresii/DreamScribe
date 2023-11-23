//
//  DreamModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

struct DreamAPIModel: Codable {
    let id: Int?
    let text: String?
    let tags: String?
    let type: DreamType?
    let createdAt: String?
    
    func toModel() -> DreamModel {
        .init(date: createdAt ?? "",
              description: text ?? "",
              tags: (tags ?? "").components(separatedBy: ","),
              type: type ?? .normal)
    }
}

struct DreamModel: Codable {
    var id: UUID = .init()
    let date: String
    let description: String
    let tags: [String]
    let type: DreamType
    
    func toApiModel() -> DreamAPIModel {
        .init(id: nil,
              text: description,
              tags: tags.joined(separator: ","),
              type: type,
              createdAt: date)
    }
}

enum DreamType: String, Codable, CaseIterable {
    case normal = "NORMAL"
    case nightmare = "NIGHTMARE"
    case lucid = "LUCID"
}
