//
//  SeasonHeader.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import Core

struct SeasonHeader: View {
    
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var presenter: SeasonsPresenter
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let url = URL(string: (colorScheme == .dark ? presenter.leagueDetails.logos.dark : presenter.leagueDetails.logos.light) ?? "") {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.4))
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            } else {
                Image("ball")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            }
            
            Text(presenter.leagueDetails.name)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
        }
        .frame(height: 220)
        .frame(maxWidth: .infinity)
        .background(.bar)
    }
}

struct SeasonHeader_Previews: PreviewProvider {
    static var previews: some View {
        SeasonHeader(presenter: .init(league: .mock(), footballDetailsRepository: FootballDetailsRepository(requestManager: .init())))
            .previewLayout(.sizeThatFits)
    }
}
