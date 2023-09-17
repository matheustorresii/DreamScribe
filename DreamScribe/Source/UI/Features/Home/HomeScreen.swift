//
//  HomeScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import Combine
import SwiftUI
struct HomeScreen: View, NavigableView {
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    var body: some View {
        ScrollView {
            
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
