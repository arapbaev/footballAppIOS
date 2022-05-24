//
//  FClub.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Fclub: Codable {
    public let team: Team
    public let note: Note?
    public let stats: [Stat]
}

extension Fclub: Equatable, Hashable {
    public static func == (lhs: Fclub, rhs: Fclub) -> Bool {
        lhs.team.displayName == rhs.team.displayName && lhs.team.shortDisplayName == rhs.team.shortDisplayName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(team.shortDisplayName)
        hasher.combine(team.displayName)
        hasher.combine(team.location)
    }
}
