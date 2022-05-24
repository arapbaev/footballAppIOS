//
//  ToolBar.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI

struct ToolBar: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .padding()
                Spacer()
                Text("Football Leagues")
                    .font(.headline)
                Spacer()
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .padding()
            }
            Divider()
        }
        .background(.bar)
    }
}

struct ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        ToolBar()
            .previewLayout(.sizeThatFits)
    }
}
