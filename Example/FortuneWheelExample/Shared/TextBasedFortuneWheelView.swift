//
//  TextBasedFortuneWheelView.swift
//  Shared
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import FortuneWheel
import SwiftUI

struct TextBasedFortuneWheelView: View {
    enum Flavor: String, CaseIterable {
        case chocolate, vanilla, strawberry
    }

    @State var selection: Flavor? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Selection:")
                Text(selection?.rawValue.capitalized ?? "NONE")
                    .bold()
            }
            .font(.title2)
            .padding()

            FortuneWheel(Flavor.allCases, selection: $selection) { flavor in
                Text(flavor.rawValue)
                    .bold()
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

struct TextBasedFortuneWheelView_Previews: PreviewProvider {
    static var previews: some View {
        TextBasedFortuneWheelView()
            .preferredColorScheme(.dark)
    }
}
