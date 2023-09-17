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
            LottieView(name: "cat")
                .frame(width: 300, height: 300)
            Text("No dreams found...")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.dreamPurple)
                .padding(.top, -40)
            Spacer()
        }
    }
}

struct HomeEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        HomeEmptyView()
    }
}
