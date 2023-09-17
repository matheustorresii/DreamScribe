//
//  HomeFloatingButton.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import SwiftUI

struct HomeFloatingButton: View {
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.dreamPurple)
                .foregroundColor(.dreamPink)
                .clipShape(Circle())
        }
        .padding()

    }
}

struct HomeFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeFloatingButton()
    }
}
