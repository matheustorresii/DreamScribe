//
//  Env.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import Foundation

var ENV: Environment = .api

enum Environment {
    case local
    case mock
    case api
    
    var port: Int {
        switch self {
        case .local:
            0
        case .mock:
            4000
        case .api:
            8080
        }
    }
}
