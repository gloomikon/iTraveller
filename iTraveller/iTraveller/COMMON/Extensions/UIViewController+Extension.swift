import UIKit
import KUIKit

extension UIViewController {
    func showToast(type: ToastType, text: String) {
        guard let view = topParent.view else {
            return
        }

        let toast = ToastView()
        toast.configure(with: type, text: text)
        toast.textColor = .black100
        toast.font = .bodyMedium
        toast.backgroundColor = .black950
        toast.layer.opacity = 0

        view.addSubview(toast)

        let bottomToTopConstraint = toast.bottomAnchor.constraint(equalTo: view.topAnchor)
        let topToTopConstraint = toast.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        NSLayoutConstraint.activate([
            toast.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toast.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toast.heightAnchor.constraint(equalToConstant: 48),
            bottomToTopConstraint
        ])

        view.layoutIfNeeded()

        bottomToTopConstraint.isActive = false
        topToTopConstraint.isActive = true

        // swiftlint:disable:next multiline_arguments
        UIView.animate(withDuration: 0.5) {
            view.layoutIfNeeded()
            toast.layer.opacity = 1
        } completion: { _ in
            topToTopConstraint.isActive = false
            bottomToTopConstraint.isActive = true
            UIView.animate(withDuration: 0.5, delay: 2) {
                view.layoutIfNeeded()
                toast.layer.opacity = 0
            }
        }
    }

    func setLoadingEnabled(_ enabled: Bool) {
        guard let view = topParent.view else {
            return
        }

        if enabled {
            let loadingView = LoadingView()
            view.addSubview(loadingView)
            NSLayoutConstraint.activate([
                loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                loadingView.topAnchor.constraint(equalTo: view.topAnchor),
                loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            loadingView.show()
        } else {
            guard let loadingView = view.subviews.first(where: { $0 is LoadingView }) as? LoadingView else {
                return
            }

            loadingView.hide { _ in
                loadingView.removeFromSuperview()
            }
        }

    }
}
