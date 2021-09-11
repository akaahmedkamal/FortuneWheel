//
//  SpinWheelBolt.swift
//  FortuneWheel
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct SpinWheelBolt: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(outerColor)
                .frame(width: 50, height: 50)
                .shadow(radius: 6)
                .overlay(RoundedBorder(cornerRadius: 25))

            Circle()
                .fill(Color.yellow)
                .frame(width: 25, height: 25)
                .overlay(RoundedBorder(cornerRadius: 12.5))
                .shadow(radius: 6)
        }
    }

    private var outerColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.yellow, .orange, .yellow]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct SpinWheelBolt_Previews: PreviewProvider {
    static var previews: some View {
        SpinWheelBolt()
    }
}
