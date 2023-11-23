//
//  Request.swift
//  DreamScribe
//
//  Created by Matheus Torres on 22/11/23.
//

import Foundation

enum RequestError: Error {
    case connection
    case client
    case server
    case parsing
    case unknown
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var body: Codable? { get }
}

enum Request: RequestProtocol {
    case getAllDreams
    case createDream(dream: DreamAPIModel)
    case deleteDreamById(id: Int)
    
    var endpoint: String {
        switch self {
        case .getAllDreams, .createDream:
            return "/dreams"
        case .deleteDreamById(let id):
            return "/dreams/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllDreams:
            return .get
        case .createDream:
            return .post
        case .deleteDreamById:
            return .delete
        }
    }
    
    var body: Codable? {
        switch self {
        case .createDream(let dream):
            return dream
        default:
            return nil
        }
    }
}
