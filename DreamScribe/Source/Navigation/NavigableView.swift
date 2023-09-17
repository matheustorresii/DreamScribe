//
//  NavigableView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import Combine
import SwiftUI

protocol NavigableView: View {
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> { get }
}
