//
//  RequestManager.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
import Combine

public class RequestManager: RequestManagerProtocol {
    private let apiManager: APIManagerProtocol
    private let parser: DataParserProtocol
    
    public init(apiManager: APIManagerProtocol = APIManager(),
         parser: DataParserProtocol = DataParser()) {
      self.apiManager = apiManager
      self.parser = parser
    }
    
    
    /// Async/Await
    public func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await apiManager.performAsync(request)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
    
    /// Combine
    public func perform<T: Decodable>(_ request: RequestProtocol) throws -> AnyPublisher<T,Error> {
        
        return try apiManager.performCombine(request)
            .tryMap { [weak self] data in
                guard let self = self else { throw URLError(.unknown) }
                let decoded: T = try self.parser.parse(data: data)
                return decoded
            }
            .eraseToAnyPublisher()
    }
    
    /// Closure
    public func perform<T: Decodable>(_ request: RequestProtocol, completion: @escaping ((Result<T,Error>) -> Void)) throws {
        try apiManager.perform(request) { [weak self] result in
            guard let self = self else {
                completion(.failure(URLError(.unknown)))
                return
            }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let decoded: T = try self.parser.parse(data: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
