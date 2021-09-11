//
//  RoundedBorder.swift
//  FortuneWheel
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct RoundedBorder: View {
    let cornerRadius: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(lineWidth: 0.5)
            .foregroundColor(.black.opacity(0.5))
    }
}

struct RoundedBorder_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 150, height: 150)
                .overlay(RoundedBorder(cornerRadius: 150))
        }
    }
}
