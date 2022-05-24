//
//  AllLeaguesView.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import Core
import Combine

struct AllLeaguesView: View {
    
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @StateObject var presenter: LeaguesPresenter
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ToolBar()
            List {
                ForEach(presenter.leagues) { league in
                    LeagueRow(league: league)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            presenter.leaguePressed(league: league)
                        }
                }
            }
            .listStyle(.plain)
            .refreshable {
                await presenter.getAvailableLeagues()
            }
            .task {
                if presenter.leagues.isEmpty {
                    await presenter.getAvailableLeagues()
                }
            }
            .onChange(of: colorScheme) { _ in
                Task {
                    await presenter.getAvailableLeagues()
                }
            }
            .alert(presenter.errorMessage?.message ?? "Error", isPresented: $presenter.showError) {
                Button("OK", role: .cancel) { }
            }
        }
        .overlay {
            if presenter.isLoading && !presenter.showError {
                ProgressView("Finding available Leagues...")
            }
        }
        .navigationBarHidden(true)
    }
}

struct AllLeaguesView_Previews: PreviewProvider {
    static var previews: some View {
        AllLeaguesView(presenter: .init(footballDetailsRepository: FootballDetailsRepository(requestManager: .init())))
    }
}

