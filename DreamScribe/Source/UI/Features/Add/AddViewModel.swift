//
//  AddViewModel.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Foundation

enum AddViewState {
    case idle
    case loading
    case created
    case error
}

final class AddViewModel: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published private(set) var state: AddViewState = .idle
    
    // MARK: - PRIVATE PROPERTIES
    
    private let createDreamUseCase: CreateDreamUseCaseProtocol = CreateDreamUseCase()
    
    // MARK: - PUBLIC METHODS
    
    func saveDream(_ dream: DreamModel) {
        state = .loading
        Task { @MainActor in
            guard let _ = try? await createDreamUseCase.execute(dream: dream) else {
                state = .error
                return
            }
            state = .created
        }
    }
}
