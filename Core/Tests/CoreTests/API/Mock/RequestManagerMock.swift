//
//  RequestManagerMock.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation
import Combine
@testable import Core

class RequestManagerMock: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol, parser: DataParserProtocol = DataParser()) {
      self.apiManager = apiManager
      self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.performAsync(request)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
    
    func perform<T>(_ request: RequestProtocol) throws -> AnyPublisher<T, Error> where T : Decodable {
        return try apiManager.performCombine(request)
            .tryMap { [weak self] data in
                guard let self = self else { throw URLError(.unknown) }
                let decoded: T = try self.parser.parse(data: data)
                return decoded
            }
            .eraseToAnyPublisher()
    }
    
    func perform<T>(_ request: RequestProtocol, completion: @escaping ((Result<T, Error>) -> Void)) throws where T : Decodable {
        try apiManager.perform(request, completion: { result in
            if case .success(let data) = result {
                do {
                    let decoded: T = try self.parser.parse(data: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
        })
    }
}
