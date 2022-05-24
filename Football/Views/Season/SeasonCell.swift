//
//  SeasonCell.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI

struct SeasonCell: View {
    // MARK: - Properties
    let name: String
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Image("ball")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.15)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .fill(.gray)
                }
            Text(name)
                .font(.footnote)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct SeasonCell_Previews: PreviewProvider {
    static var previews: some View {
        SeasonCell(name: "2020-21 Argentine Copa de la Liga preofessional de Futbol")
            .previewLayout(.sizeThatFits)
    }
}
