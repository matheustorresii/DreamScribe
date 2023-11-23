//
//  NetworkOperation.swift
//  DreamScribe
//
//  Created by Matheus Torres on 22/11/23.
//

import Foundation

protocol NetworkOperationProtocol {
    func request<T: Decodable>(_ request: RequestProtocol) async throws -> T
    func request(_ request: RequestProtocol) async throws -> Bool
}

final class NetworkOperation: NetworkOperationProtocol {
    // MARK: - PRIVATE PROPERTIES
    
    private let baseUrl: String = "http://localhost:8080/api"
    
    // MARK: - PUBLIC METHODS
    
    func request<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let urlRequest = try getUrlRequestFor(request: request)
        
        guard let (data, _) = try? await URLSession.shared.data(for: urlRequest) else {
            throw RequestError.connection
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.parsing
        }
        
        return decodedData
    }
    
    func request(_ request: RequestProtocol) async throws -> Bool {
        let urlRequest = try getUrlRequestFor(request: request)
        
        guard let (_, _) = try? await URLSession.shared.data(for: urlRequest) else {
            throw RequestError.connection
        }
        
        return true
    }
    
    private func getUrlRequestFor(request: RequestProtocol) throws -> URLRequest {
        guard let url = URL(string: baseUrl + request.endpoint) else { throw RequestError.client }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if let requestBody = request.body, let encodedBody = try? JSONEncoder().encode(requestBody) {
            urlRequest.httpBody = encodedBody
        }
        return urlRequest
    }
}
