//
//  Note.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Note: Codable {
    public let hexColor: String
    public let description: String
    public let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case hexColor = "color"
        case description, rank
    }
}
