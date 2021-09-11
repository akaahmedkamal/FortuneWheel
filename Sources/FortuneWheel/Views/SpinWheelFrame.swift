//
//  SpinWheelFrame.swift
//  FortuneWheel
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct SpinWheelFrame: View {
    private let size: CGFloat
    private let strokeWidth: CGFloat = 15

    init(size: CGFloat) {
        self.size = size
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size)
                .strokeBorder(outerColor, lineWidth: strokeWidth)
                .shadow(radius: 6)

            RoundedRectangle(cornerRadius: size)
                .stroke(lineWidth: 0.5)
                .foregroundColor(.black.opacity(0.5))
        }
        .padding(-(strokeWidth / 2))
    }

    private var outerColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.yellow, .orange, .yellow]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct SpinWheelFrame_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Circle()
                .fill(Color.orange)
                .frame(width: 150, height: 150)
                .overlay(SpinWheelFrame(size: 150))
        }
    }
}
