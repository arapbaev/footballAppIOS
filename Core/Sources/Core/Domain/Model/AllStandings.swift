//
//  AllStandings.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public struct AllStandings: Codable {
    public let status: Bool
    public let data: StandingsData
}

/*
 {
   "status": true,
   "data": {
     "name": "English Premier League",
     "abbreviation": "Prem",
     "seasonDisplay": "2020-2021",
     "season": 2020,
     "standings": []
    }
 }
 */
