//
//  LoadingView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            VStack {
                LottieView(name: "cat")
                    .frame(width: 250, height: 250)
                Text("Loading...")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                    .padding(.top, -50)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
