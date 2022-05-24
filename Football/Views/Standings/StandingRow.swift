//
//  StandingRow.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/24/22.
//

import SwiftUI
import Core

struct StandingRow: View {
    // MARK: - Properties
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    let position: Int
    let club: Fclub
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Text(String(position))
                    .font(.caption)
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color(hex: club.note?.hexColor ?? "") ?? .gray))
                
                if let url = URL(string: club.team.logos?.first?.url ?? "") {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.gray.opacity(0.4))
                            .cornerRadius(5)
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                } else {
                    Image("ball")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .cornerRadius(4)
                }
                
                Text(club.team.displayName)
                    .font(.callout)
                
                Spacer(minLength: 0)
                HStack(spacing: 6) {
                    Text(club.stats.getStatValue(type: .wins))
                        .frame(width: 25)
                    Divider()
                        .padding(.vertical, 10)
                    Text(club.stats.getStatValue(type: .losses))
                        .frame(width: 25)
                    Divider()
                        .padding(.vertical, 10)
                    if heightSizeClass == .compact {
                        Text(club.stats.getStatValue(type: .ties))
                            .frame(width: 25)
                        Divider()
                            .padding(.vertical, 10)
                        Text(club.stats.getStatValue(type: .pointsfor))
                            .frame(width: 25)
                        Divider()
                            .padding(.vertical, 10)
                        Text(club.stats.getStatValue(type: .pointsagainst))
                            .frame(width: 25)
                        Divider()
                            .padding(.vertical, 10)
                        Text(club.stats.getStatValue(type: .pointdifferential))
                            .frame(width: 32)
                        Divider()
                            .padding(.vertical, 10)
                    }
                    Text(club.stats.getStatValue(type: .points))
                        .frame(width: 32)
                }
                .font(.caption)
                .frame(width: heightSizeClass == .compact ? 210 : 94)
                .padding(.horizontal, heightSizeClass == .compact ? 14 : 4)
            }
            Divider()
        }
    }
}
