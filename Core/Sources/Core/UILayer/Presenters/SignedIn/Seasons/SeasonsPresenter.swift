//
//  SeasonsPresenter.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

@MainActor
public class SeasonsPresenter: ObservableObject {
    
    // MARK: - Properties
    private var navigator: GoToSeasonNavigator?
    public var leagueDetails: League
    @Published public var isLoading: Bool
    @Published public var seasons = [Season]()
    @Published public var showError: Bool = false
    public var errorMessage: ErrorMessage?
    private let footballDetailsRepository: FootballDetailsRepositoryProtocol
    
    // MARK: - Methods
    public init(league: League,
                isLoading: Bool = true,
                footballDetailsRepository: FootballDetailsRepositoryProtocol,
                navigator: GoToSeasonNavigator? = nil) {
        self.leagueDetails = league
        self.navigator = navigator
        self.isLoading = isLoading
        self.footballDetailsRepository = footballDetailsRepository
    }
    
    public func getAvailableSeasons(sort: SortType = .ascending) async {
        seasons = []
        isLoading = true
        do {
            let seasons = try await footballDetailsRepository.getSeasonDetails(id: leagueDetails.id, sort: sort)
            self.seasons = seasons.data.seasons
        } catch {
            print("Error", error)
            errorMessage = ErrorMessage(title: "Oops, something went wrong!", message: error.localizedDescription)
            showError = true
        }
        isLoading = false
    }
    
    public func seasonPressed(season: Season) {
        navigator?.navigateToSeasonDetails(league: leagueDetails, season: season)
    }
}
