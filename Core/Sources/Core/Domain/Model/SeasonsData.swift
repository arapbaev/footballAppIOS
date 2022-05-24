//
//  SeasonsData.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct SeasonsData: Codable {
    public let description: String
    public let seasons: [Season]
    
    enum CodingKeys: String, CodingKey {
        case description = "desc"
        case seasons
    }
}
