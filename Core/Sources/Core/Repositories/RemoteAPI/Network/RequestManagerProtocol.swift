//
//  RequestManagerProtocol.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
import Combine

protocol RequestManagerProtocol {
    /// Async/Await
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
    /// Combine
    func perform<T: Decodable>(_ request: RequestProtocol) throws -> AnyPublisher<T,Error>
    /// Closure
    func perform<T: Decodable>(_ request: RequestProtocol, completion: @escaping ((Result<T,Error>) -> Void)) throws
}
