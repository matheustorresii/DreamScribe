//
//  AddScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Combine
import SwiftUI

struct AddScreen: View, NavigableView {
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

