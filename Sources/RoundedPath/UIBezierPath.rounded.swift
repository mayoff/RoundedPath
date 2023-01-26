#if canImport(UIKit)

import UIKit

extension UIBezierPath {
    public func copy(roundingCornersToRadius radius: CGFloat) -> UIBezierPath {
        let cgCopy = self.cgPath.copy(roundingCornersToRadius: radius)
        return UIBezierPath(cgPath: cgCopy)
    }
}

#endif
