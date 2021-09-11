//
//  ImageBasedFortuneWheelView.swift
//  Shared
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import FortuneWheel
import SwiftUI

struct ImageBasedFortuneWheelView: View {
    enum Shapes: String, CaseIterable {
        case triangle = "triangle.fill"
        case rectangle = "rectangle.fill"
        case diamond = "diamond.fill"
        case heart = "heart.fill"
    }

    @State var selection: Shapes? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Selection:")
                Text(selection?.rawValue.capitalized ?? "NONE")
                    .bold()
            }
            .font(.title2)
            .padding()

            FortuneWheel(Shapes.allCases, selection: $selection) { shape in
                Image(systemName: shape.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .shadow(radius: 5)
            }
            .padding()

            HStack {
                Image(systemName: "hand.draw.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding()

                Text("Spin the Wheel")
                    .font(.title)
            }
            .padding()
        }
    }
}

struct ImageBasedFortuneWheelView_Previews: PreviewProvider {
    static var previews: some View {
        ImageBasedFortuneWheelView()
            .preferredColorScheme(.dark)
    }
}
