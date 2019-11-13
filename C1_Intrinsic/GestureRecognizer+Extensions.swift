import UIKit

internal enum Direction {
    case up
    case down
    case left
    case right
}

//MARK: - UIPanGestureRecognizer
internal extension UIPanGestureRecognizer {
    var direction: Direction? {
        let velocity = self.velocity(in: view)
        let isVertical = abs(velocity.y) > abs(velocity.x)

        switch (isVertical, velocity.x, velocity.y) {
            case (true, _, let y) where y < 0: return .up
            case (true, _, let y) where y > 0: return .down
            case (false, let x, _) where x > 0: return .right
            case (false, let x, _) where x < 0: return .left
            default: return nil
        }
    }
}
