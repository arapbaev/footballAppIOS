//
//  LeaguesPresenter.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation

@MainActor
public class LeaguesPresenter: ObservableObject {
    
    // MARK: - Properties
    private var navigator: GoToLeagueNavigator?
    @Published public var isLoading: Bool
    @Published public var leagues = [League]()
    @Published public var showError: Bool = false
    public var errorMessage: ErrorMessage?
    private let footballDetailsRepository: FootballDetailsRepositoryProtocol
    
    // MARK: - Methods
    public init(isLoading: Bool = true,
                footballDetailsRepository: FootballDetailsRepositoryProtocol,
                navigator: GoToLeagueNavigator? = nil) {
        self.navigator = navigator
        self.isLoading = isLoading
        self.footballDetailsRepository = footballDetailsRepository
    }
    
    public func getAvailableLeagues() async {
        leagues = []
        isLoading = true
        do {
            let leagues = try await footballDetailsRepository.getAvailableLeagues()
            self.leagues = leagues.data
        } catch {
            errorMessage = ErrorMessage(title: "Oops, something went wrong!", message: error.localizedDescription)
            showError = true
        }
        isLoading = false
    }
    
    public func leaguePressed(league: League) {
        navigator?.navigateToLeagueDetails(league: league)
    }
}
