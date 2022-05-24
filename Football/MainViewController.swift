//
//  MainViewController.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import UIKit
import SwiftUI
import Core
import Combine

class MainViewController: NiblessNavigationController {
  
    // MARK: - Properties
    let presenter: MainPresenter
    var subscriptions = Set<AnyCancellable>()
    
    // Child View Controllers
    let leaguesViewController: UIViewController
    var seasonsViewController: UIViewController?
    var standingsViewController: UIViewController?
    
    // Factories
    let makeSeasonsViewController: (League) -> UIViewController
    let makeStandingsViewController: (League, Season) -> UIViewController
    
    // MARK: - Methods
    init(presenter: MainPresenter,
         leaguesViewController: UIViewController,
         makeSeasonsViewController: @escaping (League) -> UIViewController,
         makeStandingsViewController: @escaping (League, Season) -> UIViewController) {
        self.presenter = presenter
        self.leaguesViewController = leaguesViewController
        self.makeSeasonsViewController = makeSeasonsViewController
        self.makeStandingsViewController = makeStandingsViewController
        super.init()
        self.delegate = self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let navigationActionPublisher = presenter.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    func subscribe(to publisher: AnyPublisher<FootballNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }

    func respond(to navigationAction: FootballNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }

    func present(view: MainView) {
        switch view {
        case .allLeagues:
            presentLeagues()
        case .allSeasons(league: let league):
            presentSeasons(league: league)
        case .standings(league: let league, season: let season):
            presentStandings(league: league, season: season)
        }
    }

    func presentLeagues() {
        pushViewController(leaguesViewController, animated: false)
    }

    func presentSeasons(league: League) {
        seasonsViewController = makeSeasonsViewController(league)
        if let seasonsViewController = seasonsViewController {
            pushViewController(seasonsViewController, animated: true)
        }
    }

    func presentStandings(league: League, season: Season) {
        standingsViewController = makeStandingsViewController(league, season)
        if let standingsViewController = standingsViewController {
            pushViewController(standingsViewController, animated: true)
        }
    }
    
}


// MARK: - Navigation Bar Presentation
extension MainViewController {

    func hideOrShowNavigationBarIfNeeded(for view: MainView, animated: Bool) {
        if view.hidesNavigationBar {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }

    func hideNavigationBar(animated: Bool) {
      if animated {
          transitionCoordinator?.animate(alongsideTransition: { context in
              self.setNavigationBarHidden(true, animated: animated)
          })
      } else {
          setNavigationBarHidden(true, animated: false)
      }
    }

    func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension MainViewController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
        guard let viewToBeShown = onboardingView(associatedWith: viewController) else { return }
        hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
        guard let shownView = onboardingView(associatedWith: viewController) else { return }
        presenter.uiPresented(mainView: shownView)
    }
    
    func onboardingView(associatedWith viewController: UIViewController) -> MainView? {
        
        switch viewController {
        case is UIHostingController<AllLeaguesView>:
            return .allLeagues
        case is UIHostingController<SeasonsView>:
            return .allSeasons(league: .mock())
        case is UIHostingController<StandingsView>:
            return .standings(league: .mock(), season: .mock())
        default:
            return .none
        }
    }
}
