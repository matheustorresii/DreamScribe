//
//  AnalyticsViewModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

class AnalyticsViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var dreams: [DreamModel] = []
    private let dreamsAppStorageKey = "DREAMS"
    
    // MARK: - INITIALIZERS
    
    init() {
        setupDreams()
    }
    
    // MARK: - PUBLIC METHODS
    
    func dreamCount() -> Int {
        dreams.count
    }
    
    func getCountFor(type: DreamType) -> Int {
        let typeArray = dreams.map { $0.type }
        let countedSet = NSCountedSet(array: typeArray)
        let count = countedSet.count(for: type)
        return count
    }
    
    func getMostRepeatedTag() -> String {
        let tags = dreams.flatMap { $0.tags }
        var counts = [String: Int]()
        tags.forEach { counts[$0] = (counts[$0] ?? 00) + 1 }
        
        if let (value, _) = counts.max(by: { $0.1 < $1.1 }) {
            return value
        }
        return ""
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupDreams() {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              let savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { return }
        dreams = savedDreams
    }
}
