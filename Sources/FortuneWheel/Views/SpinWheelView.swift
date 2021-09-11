//
//  SpinWheelView.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 19/04/21.
//

import SwiftUI

struct SpinWheelView<Data, Content>: View where Data: RandomAccessCollection, Content: View {
    @ObservedObject private var vm: FortuneWheelViewModel<Data, Content>

    private let colors: [Color]
    private let overflow: FortuneWheelOverflow
    private let offsets: [Double]
    private let sliceOffset: Double

    init(vm: FortuneWheelViewModel<Data, Content>, colors: [Color], overflow: FortuneWheelOverflow) {
        self.vm = vm
        self.colors = colors
        self.overflow = overflow
        offsets = vm.data.indices.map { _ in Double(100 / vm.data.count) }
        sliceOffset = -.pi / 2
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ForEach(0 ..< vm.data.count, id: \.self) { index in
                    SpinWheelCell(
                        startAngle: startAngle(for: index),
                        endAngle: endAngle(for: index)
                    )
                    .fill(colors[index % colors.count])

                    if overflow == .wrap {
                        renderContent(for: index, in: geo.size)
                            .frame(maxWidth: geo.size.width / 2.5)
                            .fixedSize()
                    } else {
                        renderContent(for: index, in: geo.size)
                    }
                }
            }
        }
    }

    private func renderContent(for index: Int, in size: CGSize) -> some View {
        vm.contentRenderer(vm.data[index as! Data.Index])
            .rotationEffect(contentAngle(for: index))
            .offset(contentOffset(for: index, in: size))
    }

    private func startAngle(for index: Int) -> Double {
        switch index {
        case 0:
            return sliceOffset
        default:
            let ratio = offsets[..<index].reduce(0, +) / offsets.reduce(0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }

    private func endAngle(for index: Int) -> Double {
        switch index {
        case offsets.count - 1:
            return sliceOffset + 2 * .pi
        default:
            let ratio = offsets[..<(index + 1)].reduce(0, +) / offsets.reduce(0, +)
            return sliceOffset + 2 * .pi * ratio
        }
    }

    private func contentOffset(for index: Int, in size: CGSize) -> CGSize {
        let radius = min(size.width, size.height) / 3.5
        let dataRatio = (2 * offsets[..<index].reduce(0, +) + offsets[index]) / (2 * offsets.reduce(0, +))
        let angle = CGFloat(sliceOffset + 2 * .pi * dataRatio)
        return CGSize(width: radius * cos(angle), height: radius * sin(angle))
    }

    private func contentAngle(for index: Int) -> Angle {
        let dataRatio = (2 * offsets[..<index].reduce(0, +) + offsets[index]) / (2 * offsets.reduce(0, +))
        let angle = Double(sliceOffset + 2 * .pi * dataRatio)
        return Angle(radians: angle)
    }
}

#if DEBUG
    enum SpinWheelView_Previews: PreviewProvider {
        static var previews: some View {
            let vm = FortuneWheelViewModel(
                data: ["Item 0", "Item 1", "Item 2"],
                selection: .constant(nil)
            ) { Text($0).font(.title) }

            return VStack {
                SpinWheelView(vm: vm, colors: defaultWheelColors, overflow: .wrap)
                    .frame(height: 320)
                    .padding(.vertical, 50)
                    .preferredColorScheme(.dark)
            }
        }
    }
#endif
