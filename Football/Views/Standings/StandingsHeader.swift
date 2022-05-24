//
//  StandingsHeader.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/24/22.
//

import SwiftUI
import Core

struct StandingsHeader: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @ObservedObject var presenter: StandingsPresenter
    
    // MARK: - Body
    var body: some View {
        VStack {
            if heightSizeClass == .compact {
                HStack(alignment: .center) {
                    LeagueIconView(presenter: presenter)
                    LeagueTextView(presenter: presenter)
                        .padding(.top)
                }
            } else {
                VStack {
                    LeagueIconView(presenter: presenter)
                    LeagueTextView(presenter: presenter)
                }
            }
            
        }
        .frame(height: heightSizeClass == .compact ? 160 : 270)
        .frame(maxWidth: .infinity)
        .background(.bar)
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                Divider()
                HStack {
                    Text(String("#"))
                        .font(.caption)
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding(.leading, 15)
                    
                    Text("TEAM")
                        .font(.callout)
                        .padding(.leading, 10)
                    
                    Spacer(minLength: 0)
                    HStack(spacing: 6) {
                        Text("W")
                            .frame(width: 25)
                        Divider()
                            .padding(.vertical, 10)
                        Text("L")
                            .frame(width: 25)
                        Divider()
                            .padding(.vertical, 10)
                        if heightSizeClass == .compact {
                            Text("T")
                                .frame(width: 25)
                            Divider()
                                .padding(.vertical, 10)
                            Text("+")
                                .frame(width: 25)
                            Divider()
                                .padding(.vertical, 10)
                            Text("-")
                                .frame(width: 25)
                            Divider()
                                .padding(.vertical, 10)
                            Text("+/-")
                                .frame(width: 32)
                            Divider()
                                .padding(.vertical, 10)
                        }
                        Text("PTS")
                            .frame(width: 32)
                        
                    }
                    .font(.callout)
                    .frame(width: heightSizeClass == .compact ? 210 : 94)
                    .padding(.trailing, heightSizeClass == .compact ? 30 : 20)
                }
                .frame(height: 35)
                Divider()
            }
        }
    }
}

struct StandingsHeader_Previews: PreviewProvider {
    static var previews: some View {
        StandingsHeader(presenter: .init(league: .mock(), seasonDetails: .mock(), footballDetailsRepository: FootballDetailsRepository(requestManager: .init())))
            .previewInterfaceOrientation(.portrait)
    }
}

// MARK: COMPONENTS
struct LeagueTextView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @ObservedObject var presenter: StandingsPresenter
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(presenter.leagueDetails.name)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            if presenter.standingDetails?.data.seasonDisplay != nil {
                Text(presenter.standingDetails?.data.seasonDisplay ?? "")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.bottom, 30)
            }
            
            if !presenter.isLoading && presenter.standings.isEmpty {
                Text("No available data, please try again later...")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 30)
            }
        }
    }
}

struct LeagueIconView: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @ObservedObject var presenter: StandingsPresenter
    
    // MARK: - Body
    var body: some View {
        if let url = URL(string: (colorScheme == .dark ? presenter.leagueDetails.logos.dark : presenter.leagueDetails.logos.light) ?? "") {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.4))
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 90, height: 90)
        } else {
            Image("ball")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .cornerRadius(8)
        }
    }
}
