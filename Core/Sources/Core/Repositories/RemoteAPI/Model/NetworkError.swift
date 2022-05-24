//
//  NetworkError.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL is not valid."
        }
    }
}
