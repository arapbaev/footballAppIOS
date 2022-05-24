//
//  RequestProtocol.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public protocol RequestProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryParams: [String: String] { get }
    var requestMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var bodyParams: [String: Any] { get }
}

public extension RequestProtocol {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-football-standings.azharimm.site"
    }
    
    var queryParams: [String: String] {
        return [:]
    }
    
    var bodyParams: [String: Any] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    func createURLRequest() throws -> URLRequest {
        let url = try createURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestMethod.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if !bodyParams.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
        }
        
        return urlRequest
    }
    
    private func createURL() throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        return url
    }
}
