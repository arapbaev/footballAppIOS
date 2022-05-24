//
//  APIManagerMock.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
import Combine
@testable import Core

struct APIManagerMock: APIManagerProtocol {
  func perform(_ request: RequestProtocol, authToken: String) async throws -> Data {
    return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
  }
    
    func performAsync(_ request: RequestProtocol) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }

    func performCombine(_ request: RequestProtocol) throws -> AnyPublisher<Data, Error> {
        let data = try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
        return Future<Data, Error> { promise in
            promise(.success(data))
        }
        .eraseToAnyPublisher()
    }
    
    func perform(_ request: RequestProtocol, completion: @escaping ((Result<Data, Error>) -> Void)) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
        completion(.success(data))
    }
}
