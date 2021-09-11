//
//  FortuneWheelViewModel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 19/04/21.
//

import SwiftUI

class FortuneWheelViewModel<Data, Content>: ObservableObject where Data: RandomAccessCollection, Content: View {
    @Published var degree: Double = 0

    let data: Data
    let selection: Binding<Data.Element?>
    let contentRenderer: (Data.Element) -> Content
    private let animDuration: Double
    private let animation: Animation
    private var pendingRequestWorkItem: DispatchWorkItem?

    init(
        data: Data,
        selection: Binding<Data.Element?>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.selection = selection
        contentRenderer = content
        animDuration = 5
        animation = Animation.timingCurve(0.51, 0.97, 0.56, 0.99, duration: animDuration)
    }

    func spinWheel() {
        let d = Double.random(in: 720 ... 2880)
        withAnimation(animation) {
            self.degree += d
        }

        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            if let count = self?.data.count,
               let distance = self?.degree.truncatingRemainder(dividingBy: 360)
            {
                let pointer = floor(distance / (360 / Double(count)))
                let index = count - Int(pointer) - 1
                self?.selection.wrappedValue = self?.data[index as! Data.Index]
            }
        }

        // Save the new work item and execute it after duration
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: requestWorkItem)
    }
}
