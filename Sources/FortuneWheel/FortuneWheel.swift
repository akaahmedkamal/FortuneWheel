//
//  FortuneWheel.swift
//  FortuneWheel
//
//  Created by Sameer Nawaz on 07/04/21.
//

import SwiftUI

/// A control for randomly selecting from a set of mutually exclusive values.
///
/// You create a fortune wheel by providing an array of items to select from, a selection binding,
/// and the content for the fortune wheel to display.
///
/// For example, consider the following enumeration of ice cream flavors:
///
///     enum Flavor: String, CaseIterable {
///         case chocolate, vanilla, strawberry
///     }
///
/// You can create a fortune wheel to select among these values by providing ``Text``
/// views in the fortune wheel initializer's content:
///
///     @State var selection: Flavor? = nil
///
///     FortuneWheel(Flavor.allCases, selection: $selection) { flavor in
///         Text(flavor.rawValue)
///     }
///
///     Text("Selected flavor: \(selection?.rawValue)")
///
/// ### Styling FortuneWheels
///
/// Use the style modifiers provided to control the size, colors, and the overflow behavier of the
/// fortune wheel:
///
///     @State var selection: Flavor? = nil
///
///     FortuneWheel(Flavor.allCases, selection: $selection) { flavor in
///         Text(flavor.rawValue)
///     }
///     .size(320)
///     .overflow(.wrap)
///     .colors([.red, .orange, .yellow, .pink])
///
public struct FortuneWheel<Data, Content>: View where Data: RandomAccessCollection, Content: View {
    @StateObject private var vm: FortuneWheelViewModel<Data, Content>

    private let data: Data
    private let selection: Binding<Data.Element?>
    private let contentRenderer: (Data.Element) -> Content
    private let size: CGFloat
    private let colors: [Color]
    private let overflow: FortuneWheelOverflow

    public var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                SpinWheelView(vm: vm, colors: colors, overflow: overflow)
                    .frame(width: size, height: size)
                    .overlay(SpinWheelFrame(size: size))
                    .zIndex(1)

                SpinWheelBolt()
                    .zIndex(2)
            }
            .rotationEffect(.degrees(vm.degree))
            .gesture(
                DragGesture()
                    .onChanged(onDragGestureChange)
                    .onEnded(onDragGestureEnd)
            )

            SpinWheelPointer()
                .zIndex(2)
        }
    }

    private func onDragGestureChange(value: DragGesture.Value) {
        if value.translation.width < 0 {
            vm.degree = Double(-value.translation.width)
        }
    }

    private func onDragGestureEnd(_: DragGesture.Value) {
        vm.spinWheel()
    }
}

public extension FortuneWheel {
    init(
        _ data: Data,
        selection: Binding<Data.Element?>,
        size: CGFloat = 320,
        colors: [Color] = [],
        overflow: FortuneWheelOverflow = .wrap,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.selection = selection
        contentRenderer = content
        self.size = size
        self.colors = colors.isEmpty ? defaultWheelColors : colors
        self.overflow = overflow
        _vm = StateObject(
            wrappedValue: FortuneWheelViewModel(
                data: data,
                selection: selection,
                content: content
            )
        )
    }
}

public extension FortuneWheel {
    func size(_ value: CGFloat) -> FortuneWheel<Data, Content> {
        FortuneWheel(
            data,
            selection: selection, size: value,
            colors: colors,
            overflow: overflow,
            content: contentRenderer
        )
    }
}

public extension FortuneWheel {
    func colors(_ value: [Color]) -> FortuneWheel<Data, Content> {
        FortuneWheel(
            data,
            selection: selection, size: size,
            colors: value,
            overflow: overflow,
            content: contentRenderer
        )
    }
}

public extension FortuneWheel {
    func overflow(_ value: FortuneWheelOverflow) -> FortuneWheel<Data, Content> {
        FortuneWheel(
            data,
            selection: selection, size: size,
            colors: colors,
            overflow: value,
            content: contentRenderer
        )
    }
}

let defaultWheelColors: [Color] = [
    Color(red: 236 / 255, green: 157 / 255, blue: 66 / 255),
    Color(red: 222 / 255, green: 96 / 255, blue: 55 / 255),
    Color(red: 218 / 255, green: 69 / 255, blue: 51 / 255),
    Color(red: 153 / 255, green: 44 / 255, blue: 77 / 255),
    Color(red: 67 / 255, green: 53 / 255, blue: 137 / 255),
    Color(red: 70 / 255, green: 96 / 255, blue: 168 / 255),
    Color(red: 66 / 255, green: 145 / 255, blue: 200 / 255),
]

#if DEBUG
    struct FortuneWheel_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                FortuneWheel(
                    ["Apple", "Apricot", "Clementine"],
                    selection: .constant(nil)
                ) { item in
                    Text(item)
                        .font(.title2.bold())
                }
                .padding(.vertical, 50)
            }
            .preferredColorScheme(.dark)
        }
    }
#endif
