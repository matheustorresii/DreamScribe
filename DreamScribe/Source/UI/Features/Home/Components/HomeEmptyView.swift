//
//  HomeEmptyView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import SwiftUI

struct HomeEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("sleepy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            Text("No dreams found...")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.dreamPurple)
                .padding(.top, -70)
            Spacer()
        }
    }
}

struct HomeEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEmptyView()
    }
}
