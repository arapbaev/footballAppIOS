//
//  FootballRequest.swift
//  
//
//  Created by Aslan Arapbaev on 5/22/22.
//

import Foundation

enum FootballRequest: RequestProtocol {
    case allLeagues
    case detail(id: String)
    case seasons(id: String, sort: SortType)
    case standings(id: String, sort: SortType, season: String)
    
    var path: String {
        switch self {
        case .allLeagues:
            return "/leagues"
        case .detail(id: let id):
            return "/leagues/\(id)"
        case let .seasons(id, _):
            return "/leagues/\(id)/seasons"
        case let .standings(id, _, _):
            return "/leagues/\(id)/standings"
        }
    }
    
    var queryParams: [String : String] {
        switch self {
        case let .seasons(_, sort):
            return [
                "sort": sort.urlParam
            ]
        case let .standings(_, sort, season):
            return [
                "sort": sort.urlParam,
                "season": season
            ]
        default:
            return [:]
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var requestMethod: HTTPMethod {
        return .GET
    }
}
