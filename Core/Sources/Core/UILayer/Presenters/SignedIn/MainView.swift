//
//  FootballView.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public enum MainView: Equatable {
    case allLeagues
    case allSeasons(league: League)
    case standings(league: League, season: Season)
    
    public var hidesNavigationBar: Bool {
        switch self {
        case .allLeagues:
            return true
        default:
          return false
        }
    }
}
