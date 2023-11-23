//
//  CreateDreamUseCase.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import Foundation

protocol CreateDreamUseCaseProtocol {
    func execute(dream: DreamModel) async throws -> DreamModel
}

final class CreateDreamUseCase: CreateDreamUseCaseProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkOperation: NetworkOperationProtocol
    
    // MARK: - INITIALIZERS
    
    init(networkOperation: NetworkOperationProtocol = NetworkOperation()) {
        self.networkOperation = networkOperation
    }
    
    // MARK: - PUBLIC METHODS
    
    func execute(dream: DreamModel) async throws -> DreamModel {
        if ENV == .local {
            return try localExecute(dream: dream)
        }
        
        let request = Request.createDream(dream: dream)
        
        guard let response: DreamModel = try? await networkOperation.request(request) else {
            throw RequestError.unknown
        }
        return response
    }
    
    private func localExecute(dream: DreamModel) throws -> DreamModel {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              var savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { throw RequestError.parsing }
        
        savedDreams.insert(dream, at: .zero)
        
        guard let data = try? JSONEncoder().encode(savedDreams) else { throw RequestError.parsing }
        UserDefaults.standard.set(data, forKey: dreamsAppStorageKey)
        
        return dream
    }
}
