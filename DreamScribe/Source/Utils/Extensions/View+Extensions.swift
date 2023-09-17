//
//  View+Extensions.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import SwiftUI

extension View {
    func toAny() -> AnyView {
        return .init(self)
    }
}
