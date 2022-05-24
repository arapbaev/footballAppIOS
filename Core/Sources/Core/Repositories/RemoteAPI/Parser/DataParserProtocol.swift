//
//  DataParserProtocol.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) throws -> T
}
