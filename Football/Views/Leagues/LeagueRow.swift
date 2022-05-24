//
//  LeagueRow.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI
import Core

struct LeagueRow: View {
    // MARK: - Properties
    @Environment(\.colorScheme) var colorScheme
    let league: League
    
    // MARK: - Body
    var body: some View {
        HStack {
            if let url = URL(string: (colorScheme == .dark ? league.logos.dark : league.logos.light) ?? "") {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.4))
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .cornerRadius(8)
            } else {
                Image("ball")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(league.name)
                    .bold()
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                
                Text(league.abbr)
                    .font(.subheadline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

