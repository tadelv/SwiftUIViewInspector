//
//  TouchTransparentView.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//

import Foundation
#if os(iOS)
import UIKit
#else
import AppKit
#endif

final class TouchTransparentView: PlatformView {
    var pointInsideCallback: (PlatformPoint, PlatformView) -> Void = { _, _ in }

    #if os(iOS)
        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
			superview?.isUserInteractionEnabled = false
            pointInsideCallback(point, self)
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak superview] in
				superview?.isUserInteractionEnabled = true
			}
            return false
        }
    #else
        #warning("input handling on macOS not implemented yet")
    #endif
}

