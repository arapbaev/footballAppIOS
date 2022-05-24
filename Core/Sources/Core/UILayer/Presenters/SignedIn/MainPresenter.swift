//
//  MainPresenter.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import Foundation
import Combine

public typealias FootballNavigationAction = NavigationAction<MainView>

public class MainPresenter: GoToLeagueNavigator, GoToSeasonNavigator {
    // MARK: - Properties
    @Published public private(set) var navigationAction: FootballNavigationAction = .present(view: .allLeagues)
    
    // MARK: - Methods
    public init() {}
    
    public func navigateToLeagueDetails(league: League) {
        navigationAction = .present(view: .allSeasons(league: league))
    }

    public func navigateToSeasonDetails(league: League, season: Season) {
        navigationAction = .present(view: .standings(league: league, season: season))
    }

    public func uiPresented(mainView: MainView) {
      navigationAction = .presented(view: mainView)
    }
}
