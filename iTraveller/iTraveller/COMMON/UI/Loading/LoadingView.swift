import KUIKit
import Lottie
import UIKit

class LoadingView: NibInitiableView {
    @IBOutlet var animationView: LottieAnimationView! {
        didSet {
            animationView.animation = .named("loading")
            animationView.loopMode = .loop
            animationView.backgroundBehavior = .pauseAndRestore

            animationView.tintColor = .primary500
            animationView.backgroundColor = .clear
        }
    }

    override func setup() {
        layer.opacity = 0
        isHidden = true
        backgroundColor = .background
    }

    func show() {
        animationView.play()
        setHidden(false)
    }

    func hide(completion: ((Bool) -> Void)?) {
        setHidden(true) { [weak self] completed in
            self?.animationView.stop()
            completion?(completed)
        }
    }
}
