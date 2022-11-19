import UIKit

private var activeAnimations: [UIView: Bool] = [:]

public extension UIView {
    func setHidden(
        _ hidden: Bool,
        duration: Double = 1,
        delay: TimeInterval = 0,
        completion: ((Bool) -> Void)? = nil
    ) {
        if isHidden == hidden {
            return
        }

        if activeAnimations[self] == true {
            return
        }

        activeAnimations[self] = true

        if !hidden {
            isHidden = false
        }

        // swiftlint:disable:next multiline_arguments
        UIView.animate(withDuration: duration, delay: delay) {
            self.layer.opacity = hidden ? 0 : 1
        } completion: { completed in
            if hidden {
                self.isHidden = true
            }

            activeAnimations[self] = nil
            completion?(completed)
        }
    }

    func flip(toHidden hidden: Bool, duration: Double = 0.5, completion: ((Bool) -> Void)?) {
        if isHidden == hidden {
            return
        }

        if activeAnimations[self] == true {
            return
        }

        activeAnimations[self] = true

        UIView.transition(
            with: self,
            duration: duration,
            options: [.curveEaseOut, hidden ? .transitionFlipFromTop : .transitionFlipFromBottom]
        ) {
            if !hidden {
                self.isHidden = hidden
            } else {
                self.layer.opacity = 0
            }
        } completion: { completed in
            if hidden {
                self.isHidden = hidden
                self.layer.opacity = 1
            }
            activeAnimations[self] = nil
            completion?(completed)
        }
    }
}
