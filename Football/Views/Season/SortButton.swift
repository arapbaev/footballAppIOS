//
//  SortButton.swift
//  Football
//
//  Created by Aslan Arapbaev on 5/23/22.
//

import SwiftUI

struct SortButton: View {
    @Environment(\.colorScheme) var colorScheme
    var ascendingAction: () -> Void
    var descendingAction: () -> Void
    
    var body: some View {
        Menu {
            Button(action: {
                ascendingAction()
            }) {
                Label("Date Ascending", systemImage: "arrow.down")
            }
            Button(action: {
                descendingAction()
            }) {
                Label("Date Descending", systemImage: "arrow.up")
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.square")
                .font(.body)
        }
        .padding()
    }
}

struct SortButton_Previews: PreviewProvider {
    static var previews: some View {
        SortButton(ascendingAction: {}, descendingAction: {})
            .previewLayout(.sizeThatFits)
    }
}
