import UIKit

public protocol NibInitiable {
    var nibName: String? { get }
    var nibBundle: Bundle? { get }
    var containerView: UIView? { get }
}

public extension NibInitiable where Self: UIView {
    func loadNib() {
        let viewType = type(of: self)
        let bundle = nibBundle ?? Bundle(for: viewType)
        let nibName = nibName ?? String(describing: viewType)
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        guard let containerView = containerView else {
            fatalError("Container view is not connected")
        }
        addSubview(containerView)
        translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pinToSuperview()
    }
}

open class NibInitiableView: UIView, NibInitiable {

    @IBOutlet public var containerView: UIView?
    open var nibName: String?
    open var nibBundle: Bundle?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setup()
    }

    public init(nibName: String?, bundle: Bundle?) {
        super.init(frame: .zero)
        self.nibName = nibName
        self.nibBundle = bundle
        loadNib()
        setup()
    }

    open func setup() { }
}

extension UIView {
    func pinToSuperview(withInset inset: CGFloat = 0.0) {
        guard let superview = superview else {
            fatalError("View's (\(self)) superview must not be nil.")
        }

        let superviewTopAnchor: NSLayoutYAxisAnchor = superview.topAnchor
        let superviewBottomAnchor: NSLayoutYAxisAnchor = superview.bottomAnchor
        let superviewLeadingAnchor: NSLayoutXAxisAnchor = superview.leadingAnchor
        let superviewTrailingAnchor: NSLayoutXAxisAnchor = superview.trailingAnchor

        let constraints: [NSLayoutConstraint] = [
            superviewTopAnchor.constraint(equalTo: topAnchor, constant: -inset),
            superviewBottomAnchor.constraint(equalTo: bottomAnchor, constant: inset),
            superviewLeadingAnchor.constraint(equalTo: leadingAnchor, constant: -inset),
            superviewTrailingAnchor.constraint(equalTo: trailingAnchor, constant: inset)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
