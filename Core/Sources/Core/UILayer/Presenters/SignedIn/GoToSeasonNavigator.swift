//
//  GoToSeasonNavigator.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public protocol GoToSeasonNavigator {
    func navigateToSeasonDetails(league: League, season: Season)
}
