//
//  DreamModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

struct DreamModel: Codable {
    let id: Int?
    let date: String
    let text: String
    let tags: [String]
    let type: DreamType
    
    init(id: Int? = nil,
         date: String,
         text: String,
         tags: [String],
         type: DreamType) {
        self.id = id
        self.date = date
        self.text = text
        self.tags = tags
        self.type = type
    }
    
    enum CodingKeys: CodingKey {
        case id, date, text, tags, type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.text = try container.decode(String.self, forKey: .text)
        self.tags = (try container.decode(String.self, forKey: .tags)).components(separatedBy: ",")
        self.type = try container.decode(DreamType.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let id = self.id {
            try container.encode(id, forKey: .id)
        }
        try container.encode(self.date, forKey: .date)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.tags.joined(separator: ","), forKey: .tags)
        try container.encode(self.type, forKey: .type)
    }
}

enum DreamType: String, Codable, CaseIterable {
    case normal = "NORMAL"
    case nightmare = "NIGHTMARE"
    case lucid = "LUCID"
}
