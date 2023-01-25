//
//  InspectionViewCoordinator.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//
import Foundation

extension InspectionView {
	class Coordinator: NSObject {
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

		func find(point: PlatformPoint, in view: PlatformView) {
			candidate = nil
			guard let parentViews = view.superview?.superview?.superview?.subviews else { return }
			#if os(iOS)
			for subview in parentViews where subview.frame.contains(view.convert(point, to: view.window)) &&
			subview != view.superview {
				candidate = subview
				break
			}
			#else
			for subview in parentViews where subview.frame.contains(point) &&
			subview != view.superview {
				candidate = subview
				break
			}
			#endif
		}

		private func borderView(_ size: CGSize) -> PlatformView {
			let view = PlatformView(frame: .init(origin: .zero, size: size))
			#if os(iOS)
			view.isUserInteractionEnabled = false
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

