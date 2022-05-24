//
//  League+Extension.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/24/22.
//

import Foundation
import Core

extension League {
    static func mock() -> League {
        return League(id: "arg.1",
                      name: "Argentine Liga Profesional de Fútbol",
                      abbr: "Prim A",
                      logos: .init(light: "https://a.espncdn.com/i/leaguelogos/soccer/500/1.png",
                                   dark: "https://a.espncdn.com/i/leaguelogos/soccer/500-dark/1.png"))
    }
}
