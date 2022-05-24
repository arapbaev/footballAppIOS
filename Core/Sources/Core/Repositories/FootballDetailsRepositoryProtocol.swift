//
//  FootballDetailsRepositoryProtocol.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

/// It can be changed to reactive (Combine) or completion (closure) based approach
public protocol FootballDetailsRepositoryProtocol {
    
    func getAvailableLeagues() async throws -> AllLeagues
    func getSeasonDetails(id: String, sort: SortType) async throws -> AllSeasons
    func getStandingDetails(id: String, sort: SortType, season: String) async throws -> AllStandings
}

/*
 As example of reactive solution using Combine
 
    public protocol FootballDetailsRepositoryCombine {
        
        func getAvailableLeagues() -> Future<AllLeagues, Error>
        func getSeasonDetails(id: String, sort: SortType) -> Future<AllSeasons, Error>
        func getStandingDetails(id: String, sort: SortType) -> Future<AllStandings, Error>
    }
 
*/
