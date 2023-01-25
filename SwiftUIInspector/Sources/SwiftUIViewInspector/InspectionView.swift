//
//  InspectionView.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI
#if os(macOS)
typealias PlatformView = NSView
typealias PlatformViewRepresentable = NSViewRepresentable
typealias PlatformGestureRecognizer = NSClickGestureRecognizer
typealias PlatformViewRepresentableContext = NSViewRepresentableContext
typealias PlatformColor = NSColor
typealias PlatformPoint = NSPoint
#else
import UIKit
typealias PlatformView = UIView
typealias PlatformViewRepresentable = UIViewRepresentable
typealias PlatformGestureRecognizer = UITapGestureRecognizer
typealias PlatformViewRepresentableContext = UIViewRepresentableContext
typealias PlatformColor = UIColor
typealias NSViewType = Void
typealias PlatformPoint = CGPoint
#endif

struct InspectionView: PlatformViewRepresentable {
    
    public func makeCoordinator() -> InspectionView.Coordinator {
        return Coordinator()
    }

    // MARK: iOS
    func makeUIView(context: PlatformViewRepresentableContext<InspectionView>) -> PlatformView {
        makePlatformView(context: context)
    }

    func updateUIView(_ uiView: PlatformView, context: PlatformViewRepresentableContext<InspectionView>) {

    }

    // MARK: macOS

    func makeNSView(context: Context) -> some PlatformView {
        makePlatformView(context: context)
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {}

    // MARK: agnostic
    func makePlatformView(context: PlatformViewRepresentableContext<InspectionView>) -> PlatformView {
        let view = TouchTransparentView()
		view.pointInsideCallback = context.coordinator.find
        #if os(iOS)
            view.accessibilityLabel = "InspectionView"
        #else
            view.setAccessibilityLabel("InspectionView")
        #endif
        return view
    }
}

