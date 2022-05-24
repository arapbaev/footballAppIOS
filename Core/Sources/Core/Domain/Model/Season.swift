//
//  Season.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Season: Codable {
    public let year: Int
    public let startDate: Date
    public let endDate: Date
    public let displayName: String
    
    public init(year: Int, startDate: Date, endDate: Date, displayName: String) {
        self.year = year
        self.startDate = startDate
        self.endDate = endDate
        self.displayName = displayName
    }
}

extension Season: Hashable { }

/*
 {
         "year": 2021,
         "startDate": "2021-06-01T04:00Z",
         "endDate": "2022-06-01T03:59Z",
         "displayName": "2021-22 English Premier League",
         "types": [
 // -> Same data
           {
             "id": "1",
             "name": "2021-22 English Premier League",
             "abbreviation": "2021-22 English Premier League",
             "startDate": "2021-06-01T04:00Z",
             "endDate": "2022-06-01T03:59Z",
             "hasStandings": true
           }
         ]
       }

 */
