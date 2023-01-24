//
//  InspectionView.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI
#if os(iOS)
import UIKit
#else
import AppKit
#endif

struct InspectionView: UIViewRepresentable {

  func makeUIView(context: UIViewRepresentableContext<InspectionView>) -> UIView {
    let view = UIView()
    let gesture = UITapGestureRecognizer(target: context.coordinator,
                                         action: #selector(Coordinator.tapped))
    view.addGestureRecognizer(gesture)
    view.accessibilityLabel = "InspectionView"
    context.coordinator.view = view
    return view
  }

  func updateUIView(_ uiView: UIView,
                    context: UIViewRepresentableContext<InspectionView>) {}

  public class Coordinator: NSObject {
    var view: UIView?

    private let viewTag = 898274112

    var candidate: UIView? {
      willSet {
        candidate?.viewWithTag(viewTag)?.removeFromSuperview()
      }
      didSet {
        guard let candidate else {
          return
        }
        candidate.addSubview(borderView(candidate.frame.size))
      }
    }

    override init() {}

    @objc func tapped(gesture:UITapGestureRecognizer) {
      guard let parent = view?.superview?.superview else { return }
      let point = gesture.location(in: parent)
      candidate = view?.candidateAt(point)
    }

    private func borderView(_ size: CGSize) -> UIView {
      let view = UIView(frame: .init(origin: .zero, size: size))
      view.layer.borderColor = UIColor.red.cgColor
      view.layer.borderWidth = 2.0
      view.tag = viewTag
      return view
    }
  }

  public func makeCoordinator() -> InspectionView.Coordinator {
    return Coordinator()
  }
}
