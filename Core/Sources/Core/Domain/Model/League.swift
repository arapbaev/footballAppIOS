//
//  League.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct League: Codable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let abbr: String
    public let logos: Logos
    
    public init(id: String, name: String, abbr: String, logos: Logos) {
       self.id = id
       self.name = name
       self.abbr = abbr
       self.logos = logos
   }
}

/*
 {
       "id": "arg.1",
       "name": "Argentine Liga Profesional de Fútbol",
       "slug": "argentine-liga-profesional-de-futbol",
       "abbr": "Prim A",
       "logos": {
         "light": "https://a.espncdn.com/i/leaguelogos/soccer/500/1.png",
         "dark": "https://a.espncdn.com/i/leaguelogos/soccer/500-dark/1.png"
       }
 }
 */
