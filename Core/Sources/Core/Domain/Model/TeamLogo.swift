//
//  TeamLogo.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct TeamLogo: Codable {
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "href"
    }
}

