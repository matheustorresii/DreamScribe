//
//  HomeViewModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

enum HomeViewState {
    case idle
    case content([DreamModel])
    case error
    case loading
}

final class HomeViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published private(set) var state: HomeViewState = .idle
    
    // MARK: - PRIVATE PROPERTIES
    
    private let getAllDreamsUseCase: GetAllDreamsUseCaseProtocol = GetAllDreamsUseCase()
    private let deleteDreamByIdUseCase: DeleteDreamByIdUseCaseProtocol = DeleteDreamByIdUseCase()
    private var dreams: [DreamModel] = []
    
    // MARK: - INITIALIZERS
    
    init() {
        setupDreams()
    }
    
    // MARK: - PUBLIC METHODS
    
    func removeDream(_ dream: DreamModel) {
        guard let dream = dreams.first(where: { $0.id == dream.id }) else { return }
        state = .loading
        Task { @MainActor in
            guard let _ = try? await deleteDreamByIdUseCase.execute(dreamId: dream.id) else {
                state = .error
                return
            }
            setupDreams()
        }
    }
    
    func onAppear() {
        setupDreams()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupDreams() {
        state = .loading
        Task { @MainActor in
            guard let response = try? await getAllDreamsUseCase.execute() else {
                state = .error
                return
            }
            dreams = response
            state = .content(response)
        }
    }
}
