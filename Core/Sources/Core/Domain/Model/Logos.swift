//
//  Logos.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

public struct Logos: Codable, Equatable {
    public let light: String?
    public let dark: String?
    
    public init(light: String?, dark: String?)  {
        self.light = light
        self.dark = dark
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
