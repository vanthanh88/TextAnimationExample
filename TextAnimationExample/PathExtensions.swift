//
//  PathExtensions.swift
//  funnykanji
//
//  Created by Ulaai on 7/21/16.
//  Copyright © 2016 Thanhnv. All rights reserved.
//

import UIKit

// rob mayoff's CGPath.foreach
extension CGPath {
    func forEach(_ body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(_ info: UnsafeMutableRawPointer, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
//        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
//        self.apply(info: unsafeBody, function: callback as! CGPathApplierFunction)
    }
}

// Finds the first point in a path
extension UIBezierPath {
    func firstPoint() -> CGPoint? {
        var firstPoint: CGPoint? = nil
        
        self.cgPath.forEach { element in
            // Just want the first one, but we have to look at everything
            guard firstPoint == nil else { return }
            assert(element.type == .moveToPoint, "Expected the first point to be a move")
            firstPoint = element.points.pointee
        }
        return firstPoint
    }
}
