//
//  GetAllDreamsUseCase.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import Foundation

protocol GetAllDreamsUseCaseProtocol {
    func execute() async throws -> [DreamModel]
}

final class GetAllDreamsUseCase: GetAllDreamsUseCaseProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkOperation: NetworkOperationProtocol
    
    // MARK: - INITIALIZERS
    
    init(networkOperation: NetworkOperationProtocol = NetworkOperation()) {
        self.networkOperation = networkOperation
    }
    
    // MARK: - PUBLIC METHODS
    
    func execute() async throws -> [DreamModel] {
        if ENV == .local {
            return localExecute()
        }
        
        let request = Request.getAllDreams
        guard let response: [DreamModel] = try? await networkOperation.request(request) else {
            throw RequestError.unknown
        }
        return response
    }
    
    private func localExecute() -> [DreamModel] {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              let savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { return [] }
        return savedDreams
    }
}
