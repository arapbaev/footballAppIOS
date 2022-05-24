//
//  DataParser.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
        self.jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }

    public func parse<T: Decodable>(data: Data) throws -> T {
      return try jsonDecoder.decode(T.self, from: data)
    }
}

