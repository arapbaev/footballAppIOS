//
//  Stat.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Stat: Codable {
    public let displayName: String
    public let abbreviation: String
    public let description: String
    public let displayValue: String
    public let type: StatType
}
