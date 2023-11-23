//
//  DeleteDreamByIdUseCase.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import Foundation

protocol DeleteDreamByIdUseCaseProtocol {
    func execute(dreamId: Int) async throws
}

final class DeleteDreamByIdUseCase: DeleteDreamByIdUseCaseProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkOperation: NetworkOperationProtocol
    
    // MARK: - INITIALIZERS
    
    init(networkOperation: NetworkOperationProtocol = NetworkOperation()) {
        self.networkOperation = networkOperation
    }
    
    // MARK: - PUBLIC METHODS
    
    func execute(dreamId: Int) async throws {
        if ENV == .local {
            return localExecute(dreamId: dreamId)
        }
        
        let request = Request.deleteDreamById(id: dreamId)
        guard let response = try? await networkOperation.request(request), response else {
            throw RequestError.unknown
        }
    }
    
    private func localExecute(dreamId: Int) {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              var savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { return }
        
        guard let index = savedDreams.firstIndex(where: { $0.id == dreamId }) else { return }
        
        savedDreams.remove(at: index)
        
        guard let data = try? JSONEncoder().encode(savedDreams) else { return }
        UserDefaults.standard.set(data, forKey: dreamsAppStorageKey)
    }
}
