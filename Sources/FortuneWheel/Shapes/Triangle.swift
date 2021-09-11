//
//  File.swift
//  File
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let a = CGPoint(x: rect.midX, y: rect.minY)
        let b = CGPoint(x: rect.minX, y: rect.maxY)
        let c = CGPoint(x: rect.maxX, y: rect.maxY)
        let d = CGPoint(x: rect.maxX, y: rect.minY)

        path.move(to: a)
        path.addLine(to: b)
        path.addLine(to: c)
        path.addLine(to: a)
        path.addCurve(to: a, control1: d, control2: a)

        return path
    }
}
