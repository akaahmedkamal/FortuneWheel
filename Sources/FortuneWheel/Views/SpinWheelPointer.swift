//
//  SpinWheelPointer.swift
//  FortuneWheel
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct SpinWheelPointer: View {
    private let size = CGSize(width: 40, height: 60)

    var body: some View {
        ZStack {
            Triangle()
                .frame(width: size.width + 2, height: size.height + 2)
                .foregroundColor(.blue.opacity(0.5))
                .cornerRadius(size.width)
                .rotationEffect(.init(degrees: 180))

            Triangle()
                .fill(pointerColor)
                .frame(width: size.width, height: size.height)
                .cornerRadius(size.width)
                .rotationEffect(.init(degrees: 180))
                .shadow(radius: 6, y: 6)
        }
        .offset(y: -(size.width / 2))
    }

    private var pointerColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.yellow, .orange, .yellow]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct SpinWheelPointer_Previews: PreviewProvider {
    static var previews: some View {
        SpinWheelPointer()
    }
}
