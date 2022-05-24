//
//  APIManager.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
import Combine

public class APIManager: APIManagerProtocol {
    
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = URLSession.shared) {
      self.urlSession = urlSession
    }
    
    public func perform(_ request: RequestProtocol, completion: @escaping (Result<Data,Error>) -> Void) throws {
        let task = urlSession.dataTask(with: try request.createURLRequest()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidServerResponse))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    public func performAsync(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        return data
    }
    
    public func performCombine(_ request: RequestProtocol) throws -> AnyPublisher<Data,Error> {
        
        return urlSession
            .dataTaskPublisher(for: try request.createURLRequest())
            .tryMap { value in
                guard let httpResponse = value.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidServerResponse
                }
                return value.data
            }
            .eraseToAnyPublisher()
    }
}
