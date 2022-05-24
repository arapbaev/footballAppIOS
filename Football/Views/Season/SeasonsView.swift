//
//  SeasonsView.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import Core

struct SeasonsView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @StateObject var presenter: SeasonsPresenter
    let columns = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                SeasonHeader(presenter: presenter)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(presenter.seasons, id: \.self) { season in
                        SeasonCell(name: season.displayName)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                presenter.seasonPressed(season: season)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .overlay {
                if presenter.isLoading && !presenter.showError {
                    ProgressView("Finding available seasons...")
                }
            }
        }
        .task {
            if presenter.seasons.isEmpty {
                await presenter.getAvailableSeasons()
            }
        }
        .alert(presenter.errorMessage?.message ?? "Error", isPresented: $presenter.showError) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Seasons")
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView(presenter: .init(league: .mock(), footballDetailsRepository: FootballDetailsRepository(requestManager: .init())))
    }
}

