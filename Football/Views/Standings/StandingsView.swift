//
//  StandingsView.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import Core
import Combine

struct StandingsView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @StateObject var presenter: StandingsPresenter
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                StandingsHeader(presenter: presenter)
                LazyVStack {
                    ForEach(Array(presenter.standings.enumerated()), id:\.offset) { (index, club) in
                        if presenter.sortType == .ascending {
                            StandingRow(position: index + 1, club: club)
                        } else {
                            StandingRow(position: presenter.standings.count - index, club: club)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .overlay {
                if presenter.isLoading && !presenter.showError {
                    ProgressView("Finding available standings...")
                }
            }
        }
        .task {
            await presenter.getAvailableStandings()
        }
        .alert(presenter.errorMessage?.message ?? "Error", isPresented: $presenter.showError) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Standings")
        .toolbar {
            SortButton {
                Task {
                    await presenter.getAvailableStandings(sort: .ascending)
                }
            } descendingAction: {
                Task {
                    await presenter.getAvailableStandings(sort: .descending)
                }
            }
        }
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView(presenter: .init(league: .mock(), seasonDetails: .mock(), footballDetailsRepository: FootballDetailsRepository(requestManager: .init())))
    }
}
