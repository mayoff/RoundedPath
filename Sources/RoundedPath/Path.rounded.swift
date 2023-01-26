
#if canImport(SwiftUI)

import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Path {
    public func roundedPath(radius: CGFloat) -> Self {
        let cgCopy = cgPath.copy(roundingCornersToRadius: radius)
        return Path(cgCopy)
    }
}

#endif
