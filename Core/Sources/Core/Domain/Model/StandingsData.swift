//
//  StandingsData.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public struct StandingsData: Codable {
    public let name: String
    public let abbreviation: String?
    public let seasonDisplay: String
    public let season: Int
    public let standings: [Fclub]
}
