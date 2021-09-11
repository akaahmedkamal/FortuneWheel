//
//  FortuneWheelOverflow.swift
//  FortuneWheel
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import Foundation

/// An enumeration to indicate the content overflow behavior of the ``FortuneWheel``'s item.
@frozen public enum FortuneWheelOverflow {
    /// This indicates that the ``FortuneWheel``'s item content can exceed the width of the ``FortuneWheel`` itself.
    case visible
    /// This indicates that the ``FortuneWheel``'s item content can NOT exceed the width of the ``FortuneWheel``
    /// and will have a `.frame(maxWidth: ##FortuneWheelWidth/2.5)` assigned to it.
    case wrap
}
