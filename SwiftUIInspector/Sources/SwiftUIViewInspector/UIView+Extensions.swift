//
//  File.swift
//  
//
//  Created by Vid Tadel on 1/24/23.
//

#if os(iOS)
import UIKit
#else
import AppKit
#endif

extension PlatformView {
    func candidateAt(_ point: CGPoint) -> PlatformView? {
        superview?.superview?.subviews.filter {
            $0.frame.contains(point) &&
            $0 != self.superview
        }.first
    }

    func printViewAt(_ point: CGPoint) {
        print(String(describing: candidateAt(point)))
    }
}
