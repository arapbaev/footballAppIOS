//
//  FootballDetailsRepository.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

public class FootballDetailsRepository: FootballDetailsRepositoryProtocol {
    // MARK: - Properties
    let requestManager: RequestManager
    
    // MARK: - Methods
    public init(requestManager: RequestManager) {
      self.requestManager = requestManager
    }
    
    public func getAvailableLeagues() async throws -> AllLeagues {
        let leagues: AllLeagues = try await requestManager.perform(FootballRequest.allLeagues)
        return leagues
    }
    
    public func getSeasonDetails(id: String, sort: SortType) async throws -> AllSeasons {
        let seasons: AllSeasons = try await requestManager.perform(FootballRequest.seasons(id: id, sort: sort))
        return seasons
    }
    
    public func getStandingDetails(id: String, sort: SortType, season: String) async throws -> AllStandings {
        let standing: AllStandings = try await requestManager.perform(FootballRequest.standings(id: id, sort: sort, season: season))
        return standing
    }
}
