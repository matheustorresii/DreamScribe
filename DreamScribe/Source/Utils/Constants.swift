//
//  Constants.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

let dreamsAppStorageKey = "DREAMS"

let mockDreams: [DreamModel] = [
    .init(id: "\(UUID())",
          date: "Saturday, 8th August 2020",
          text: "I was in my high scholl with my friend Gabriela, trying to run from mysterious man that was searching for us.",
          tags: ["Gabriela", "High School", "Mysterious Man"],
          type: .nightmare),
    .init(id: "\(UUID())",
          date: "Monday, 9th August 2020",
          text: "It was kinda nice",
          tags: ["Happy"],
          type: .normal),
    .init(id: "\(UUID())",
          date: "Monday, 10th August 2020",
          text: """
          A really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really really long lucid dream
          """,
          tags: ["long", "really long", "a", "lot", "of", "tags", "here", "please", "make", "this", "work", "it", "would", "be", "awesome"],
          type: .lucid)
]
