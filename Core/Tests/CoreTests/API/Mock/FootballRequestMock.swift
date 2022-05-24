//
//  FootballRequestMock.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation
@testable import Core

enum FootballRequestMock: RequestProtocol {
    case allLeagues
    case seasons
    case standings
    
    var path: String {
        switch self {
        case .allLeagues:
            guard let path = Bundle.module.path(forResource: "LeaguesMock", ofType: "json") else { return "" }
            return path
        case .seasons:
            guard let path = Bundle.module.path(forResource: "SeasonsMock", ofType: "json") else { return "" }
            return path
        case .standings:
            guard let path = Bundle.module.path(forResource: "StandingsMock", ofType: "json") else { return "" }
            return path
        }
    }
    
    var requestMethod: HTTPMethod {
        return .GET
    }
}
