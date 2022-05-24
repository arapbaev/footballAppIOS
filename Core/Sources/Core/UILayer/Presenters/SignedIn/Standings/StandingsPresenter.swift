//
//  StandingsPresenter.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

@MainActor
public class StandingsPresenter: ObservableObject {
    
    // MARK: - Properties
    public let leagueDetails: League
    public let seasonDetails: Season
    @Published public var isLoading: Bool
    @Published public var standingDetails: AllStandings?
    @Published public var standings = [Fclub]()
    @Published public var showError: Bool = false
    public var sortType: SortType = .ascending
    public var errorMessage: ErrorMessage?
    private let footballDetailsRepository: FootballDetailsRepositoryProtocol
    
    // MARK: - Methods
    public init(league: League,
                seasonDetails: Season,
                isLoading: Bool = true,
                footballDetailsRepository: FootballDetailsRepositoryProtocol) {
        self.leagueDetails = league
        self.seasonDetails = seasonDetails
        self.isLoading = isLoading
        self.footballDetailsRepository = footballDetailsRepository
    }
    
    public func getAvailableStandings(sort: SortType = .ascending) async {
        standings = []
        isLoading = true
        sortType = sort
        do {
            let standings = try await footballDetailsRepository.getStandingDetails(id: leagueDetails.id, sort: sort, season: String(seasonDetails.year))
            self.standingDetails = standings
            self.standings = standings.data.standings
        } catch {
            print("Error", error)
            errorMessage = ErrorMessage(title: "Oops, something went wrong!", message: error.localizedDescription)
            showError = true
        }
        isLoading = false
    }
}
