//
//  RequestManagerTests.swift
//  
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import XCTest
import Combine
@testable import Core

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
      super.setUp()
      guard let userDefaults = UserDefaults(suiteName: #file) else { return }
      userDefaults.removePersistentDomain(forName: #file)
      requestManager = RequestManagerMock(apiManager: APIManagerMock())
    }
    
    func testRequestAsyncLeagues() async throws {
        guard let leagues: AllLeagues = try await requestManager?.perform(FootballRequestMock.allLeagues) else { return }

        let list = leagues.data
        let first = list.first
        let last = list.last
        XCTAssertEqual(leagues.status, true)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(first?.abbr, "Prim A")
        XCTAssertEqual(last?.abbr, "A Lge")
        XCTAssertEqual(first?.id, "arg.1")
        XCTAssertEqual(last?.id, "aus.1")
    }
    
    func testRequestRectiveCombineLeagues() async throws {
        guard let requestManager = requestManager else {
            XCTFail("requestManager is nil")
            return
        }
        let publisher: AnyPublisher<AllLeagues, Error> = try requestManager.perform(FootballRequestMock.allLeagues)
            
        publisher
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { leagues in
                let list = leagues.data
                let first = list.first
                let last = list.last
                XCTAssertEqual(leagues.status, true)
                XCTAssertEqual(list.count, 2)
                XCTAssertEqual(first?.abbr, "Prim A")
                XCTAssertEqual(last?.abbr, "A Lge")
                XCTAssertEqual(first?.id, "arg.1")
                XCTAssertEqual(last?.id, "aus.1")
            })
            .store(in: &cancellables)
    }
    
    func testRequestCompletionClosureLeagues() async throws {
        guard let requestManager = requestManager else {
            XCTFail("requestManager is nil")
            return
        }
        try requestManager.perform(FootballRequestMock.allLeagues, completion: { (result: Result<AllLeagues, Error>) in
            switch result {
            case .success(let leagues):
                let list = leagues.data
                let first = list.first
                let last = list.last
                XCTAssertEqual(leagues.status, true)
                XCTAssertEqual(list.count, 2)
                XCTAssertEqual(first?.abbr, "Prim A")
                XCTAssertEqual(last?.abbr, "A Lge")
                XCTAssertEqual(first?.id, "arg.1")
                XCTAssertEqual(last?.id, "aus.1")
            case .failure(let error):
                XCTFail("Recieved Error: \(error.localizedDescription)")
            }
        })
    }
    
    func testSeasonsResponseParseDataModel() async throws {
        guard let seasons: AllSeasons = try await requestManager?.perform(FootballRequestMock.seasons) else { return }
        
        let list = seasons.data.seasons
        let first = list.first
        let last = list.last
        
        XCTAssertEqual(seasons.status, true)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(first?.displayName, "2021-22 English Premier League")
        XCTAssertEqual(last?.displayName, "2020-21 English Premier League")
        XCTAssertEqual(first?.year, 2021)
        XCTAssertEqual(last?.year, 2020)
        
        guard let startDate = first?.startDate,
              let endDate = first?.endDate else {
            XCTFail("Unable to get a date")
            return
        }
        let calendarStartDate = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        let calendarEndDate = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
        
        XCTAssertEqual(calendarStartDate.year, 2021)
        XCTAssertEqual(calendarStartDate.month, 6)
        XCTAssertEqual(calendarStartDate.day, 1)
        
        XCTAssertEqual(calendarEndDate.year, 2022)
        XCTAssertEqual(calendarEndDate.month, 6)
        XCTAssertEqual(calendarEndDate.day, 1)
    }
    
    //TODO: testStandingsResponseParseDataModel()
    // 
    
}

/*
 {
   "status": true,
   "data": [
     {
       "id": "arg.1",
       "name": "Argentine Liga Profesional de Fútbol",
       "slug": "argentine-liga-profesional-de-futbol",
       "abbr": "Prim A",
       "logos": {
         "light": "https://a.espncdn.com/i/leaguelogos/soccer/500/1.png",
         "dark": "https://a.espncdn.com/i/leaguelogos/soccer/500-dark/1.png"
       }
     },
     {
       "id": "aus.1",
       "name": "Australian A-League",
       "slug": "australian-a-league",
       "abbr": "A Lge",
       "logos": {
         "light": "https://a.espncdn.com/i/leaguelogos/soccer/500/1308.png",
         "dark": "https://a.espncdn.com/i/leaguelogos/soccer/500-dark/1308.png"
       }
     }
   ]
 }
 */
