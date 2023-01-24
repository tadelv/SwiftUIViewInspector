//
//  Inspectable.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI

public struct Inspectable: ViewModifier {
    let view = InspectionView()
    public func body(content: Content) -> some View {
        content
            .overlay(view)
    }
}

public extension View {
    func inspectable() -> some View {
        self
            .modifier(Inspectable())
    }
}
