//
//  AddViewModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

class AddViewModel: ObservableObject {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var dreams: [DreamModel] = []
    private let dreamsAppStorageKey = "DREAMS"
    
    // MARK: - INITIALIZERS
    
    init() {
        setupDreams()
    }
    
    // MARK: - PUBLIC METHODS
    
    func saveDream(_ dream: DreamModel) {
        dreams.insert(dream, at: .zero)
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
