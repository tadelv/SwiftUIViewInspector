//
//  InspectionViewCoordinator.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//
import Foundation
#if os(iOS)
import UIKit
#endif

extension InspectionView {
	class Coordinator: NSObject {
		var candidate: PlatformView? {
			willSet {
				borderView?.removeFromSuperview()
				#if os(iOS)
				candidateInfoView?.removeFromSuperview()
				#endif
			}
			didSet {
				guard let candidate else {
					return
				}
				candidate.addSubview(borderView(candidate.frame.size))
				displayViewInfo(candidate)
			}
		}
		var borderView: PlatformView?
		#if os(iOS)
		var candidateInfoView: UILabel?
		#endif

		override init() {

		}

		func find(point: PlatformPoint, in view: PlatformView) {
			candidate = nil
			guard let parentViews = view.superview?.superview?.subviews else { return }
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

		func displayViewInfo(_ view: PlatformView) {
#if os(iOS)
			candidateInfoView?.removeFromSuperview()
			candidateInfoView = nil
			guard let window = view.window else {
				return
			}

			candidateInfoView = UILabel()
			guard let candidateInfoView else { return }
			candidateInfoView.translatesAutoresizingMaskIntoConstraints = false
			candidateInfoView.text = view.frame.description
			candidateInfoView.font = .monospacedDigitSystemFont(ofSize: 10, weight: .medium)
			candidateInfoView.backgroundColor = .blue
			candidateInfoView.textColor = .white
			candidateInfoView.layer.compositingFilter = "differenceBlendMode"
			candidateInfoView.sizeToFit()
			window.addSubview(candidateInfoView)
			window.bringSubviewToFront(candidateInfoView)
			NSLayoutConstraint.activate([
				candidateInfoView.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor),
				candidateInfoView.leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor),
			])
#endif
		}
	}
}

#if os(iOS)
extension CGRect {
	var description: String {
		"""
		x: \(round(origin.x * 100) / 100), y: \(round(origin.y * 100) / 100), \(round(size.width * 100) / 100)x\(round(size.height * 100) / 100)
		"""
	}
}
#endif
