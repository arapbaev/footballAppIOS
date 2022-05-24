//
//  StatType.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public enum StatType: String, Codable {
    case wins, losses, ties, gamesplayed
    case pointsfor, pointsagainst, points
    case rankchange, rank, pointdifferential
    case deductions, ppg, total
}
