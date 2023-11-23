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
        if MOCK {
            return mockExecute()
        }
        
        let request = Request.getAllDreams
        guard let response: [DreamAPIModel] = try? await networkOperation.request(request) else {
            throw RequestError.unknown
        }
        return response.map { $0.toModel() }
    }
    
    private func mockExecute() -> [DreamModel] {
        guard let data = UserDefaults.standard.data(forKey: dreamsAppStorageKey),
              let savedDreams = try? JSONDecoder().decode([DreamModel].self, from: data) else { return [] }
        return savedDreams
    }
}
