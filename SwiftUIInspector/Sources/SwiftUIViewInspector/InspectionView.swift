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
#else
import UIKit
typealias PlatformView = UIView
typealias PlatformViewRepresentable = UIViewRepresentable
typealias PlatformGestureRecognizer = UITapGestureRecognizer
typealias PlatformViewRepresentableContext = UIViewRepresentableContext
typealias PlatformColor = UIColor
typealias NSViewType = Void
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
        let view = PlatformView()
        let gesture = PlatformGestureRecognizer(target: context.coordinator,
                                                action: #selector(Coordinator.tapped))
        #if os(iOS)
            gesture.numberOfTapsRequired = 3
        #else
            gesture.numberOfClicksRequired = 3
        #endif
            view.addGestureRecognizer(gesture)
        #if os(iOS)
            view.accessibilityLabel = "InspectionView"
        #else
            view.setAccessibilityLabel("InspectionView")
        #endif
        context.coordinator.view = view
        return view
    }
}

extension InspectionView {
    class Coordinator: NSObject {

        var view: PlatformView?

        var candidate: PlatformView? {
            willSet {
                borderView?.removeFromSuperview()
            }
            didSet {
                guard let candidate else {
                    return
                }
                candidate.addSubview(borderView(candidate.frame.size))
            }
        }
        var borderView: PlatformView?

        override init() {

        }

        @objc func tapped(_ gesture: PlatformGestureRecognizer) {
            guard let parent = view?.superview?.superview else { return }
            let point = gesture.location(in: parent)
            candidate = view?.candidateAt(point)
        }

        private func borderView(_ size: CGSize) -> PlatformView {
            let view = PlatformView(frame: .init(origin: .zero, size: size))
            #if os(iOS)
                view.layer.borderColor = PlatformColor.red.cgColor
                view.layer.borderWidth = 2.0
                view.layer.compositingFilter = "differenceBlendMode"
            #else
                view.wantsLayer = true
                view.layer?.borderColor = PlatformColor.red.cgColor
                view.layer?.borderWidth = 2.0
                view.layer?.compositingFilter = "differenceBlendMode"
            #endif
            borderView = view
            return view
        }
    }
}
