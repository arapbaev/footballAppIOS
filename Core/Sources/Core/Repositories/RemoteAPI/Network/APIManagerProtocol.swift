//
//  APIManagerProtocol.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
import Combine

public protocol APIManagerProtocol {
    /// completion based request
    func perform(_ request: RequestProtocol, completion: @escaping ((Result<Data,Error>) -> Void)) throws
    /// new async/await based request
    func performAsync(_ request: RequestProtocol) async throws -> Data
    /// reactive request
    func performCombine(_ request: RequestProtocol) throws -> AnyPublisher<Data,Error>
}

