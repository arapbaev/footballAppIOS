//
//  Team.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Team: Codable {
    public let location: String
    public let abbreviation: String?
    public let displayName: String
    public let shortDisplayName: String
    public let logos: [TeamLogo]?
}
