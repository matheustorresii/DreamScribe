//
//  HomeViewModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published private(set) var dreams: [DreamModel] = []
    
    // MARK: - PRIVATE PROPERTIES
    
    private let dreamsAppStorageKey = "DREAMS"
    
    // MARK: - INITIALIZERS
    
    init() {
        setupDreams()
    }
    
    // MARK: - PUBLIC METHODS
    
    func saveDream(_ dream: DreamModel) {
        if let index = dreams.firstIndex(where: { $0.id == dream.id }) {
            dreams.remove(at: index)
        }
        dreams.insert(dream, at: .zero)
        updateDreams()
    }
    
    func removeDream(_ dream: DreamModel) {
        guard let index = dreams.firstIndex(where: { $0.id == dream.id }) else { return }
        dreams.remove(at: index)
        updateDreams()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupDreams() {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              let savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { return }
        dreams = savedDreams
    }
    
    private func updateDreams() {
        guard let data = try? JSONEncoder().encode(dreams) else { return }
        UserDefaults.standard.set(data, forKey: dreamsAppStorageKey)
    }
}
