//
//  AppDependancyContainer.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import UIKit
import Core

class AppDependencyContainer {
    
    // MARK: - Properties

    // Long-lived dependencies
    let sharedFootballDetailsRepository: FootballDetailsRepositoryProtocol
    let sharedMainPresenter: MainPresenter
    
    // MARK: - Methods
    init() {
        let apiManager = APIManager(urlSession: .shared)
        let parser = DataParser()
        sharedFootballDetailsRepository = FootballDetailsRepository(requestManager: RequestManager(apiManager: apiManager,
                                                                                                   parser: parser))
        sharedMainPresenter = MainPresenter()
    }
    
    @MainActor func makeMainViewController() -> MainViewController {
        let leaguesViewController = makeLeaguesViewController()
        
        let seasonsViewControllerFactory = { (league: League) in
            return self.makeSeasonsViewController(league: league)
        }
        
        let standingsViewControllerFactory = { (league: League, season: Season) in
            return self.makeStandingsViewController(league: league, season: season)
        }
        
        return MainViewController(presenter: sharedMainPresenter,
                                  leaguesViewController: leaguesViewController,
                                  makeSeasonsViewController: seasonsViewControllerFactory,
                                  makeStandingsViewController: standingsViewControllerFactory)
    }
    
    // LEAGUES
    @MainActor func makeLeaguesViewController() -> UIViewController {
        let leaguesPresenter = makeLeaguesPresenter()
        let leaguesView = UIHostingController(rootView: AllLeaguesView(presenter: leaguesPresenter))
        return leaguesView
    }
    
    @MainActor func makeLeaguesPresenter() -> LeaguesPresenter {
        return LeaguesPresenter(footballDetailsRepository: sharedFootballDetailsRepository, navigator: sharedMainPresenter)
    }
    
    // SEASONS
    @MainActor func makeSeasonsViewController(league: League) -> UIViewController {
        let seasonsPresenter = makeSeasonsPresenter(league: league)
        let seasonsView = UIHostingController(rootView: SeasonsView(presenter: seasonsPresenter))
        return seasonsView
    }
    
    @MainActor func makeSeasonsPresenter(league: League) -> SeasonsPresenter {
        return SeasonsPresenter(league: league, footballDetailsRepository: sharedFootballDetailsRepository, navigator: sharedMainPresenter)
    }
    
    // STANDINGS
    @MainActor func makeStandingsViewController(league: League, season: Season) -> UIViewController {
        let standingsPresenter = makeStandingsPresenter(league: league, season: season)
        let standingsView = UIHostingController(rootView: StandingsView(presenter: standingsPresenter))
        return standingsView
    }
    
    @MainActor func makeStandingsPresenter(league: League, season: Season) -> StandingsPresenter {
        return StandingsPresenter(league: league, seasonDetails: season, footballDetailsRepository: sharedFootballDetailsRepository)
    }
}

