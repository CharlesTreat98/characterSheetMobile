//
//  ControllerExtensions.swift
//  CharSheet
//
//  Created by Charlie Treat on 1/29/22.
//

import UIKit

extension UIViewController {

    @objc
    public func addChildViewController(_ childViewController: UIViewController, toView view: UIView, constraints: [NSLayoutConstraint]) {
        addChild(childViewController)

        let subview = childViewController.view!
        view.addSubview(subview)

        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)

        childViewController.didMove(toParent: self)
    }

    /// This method allows developers to present "form sheet" view controllers that pop up form the bottom of the screen
    /// in compact mode and centered sheet on larger screens. These view controllers should be dismisses via the
    /// navigation view controller or by the user sliding down. 
    public func presentModally(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .formSheet

        present(navigationController, animated: true)
    }
}

extension UIView {

    @objc
    public func constraintsForConstraining(to view: UIView) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }

    @objc
    public func constrain(to view: UIView) {
        NSLayoutConstraint.activate(constraintsForConstraining(to: view))
    }

    @objc
    public func constrain(toGuide guide: UILayoutGuide) {
        NSLayoutConstraint.activate(constraintsForConstraining(toGuide: guide))
    }

    @objc
    public func constraintsForConstraining(toGuide guide: UILayoutGuide) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topAnchor.constraint(equalTo: guide.topAnchor),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ]
    }
}


extension UIStackView {

    /// The order of these properties matches the order found in Interface Builder, which
    /// may help make it "easier" to translate IB mock-ups to code.
    public convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        spacing: CGFloat = UIStackView.spacingUseSystem
    ) {
        self.init(arrangedSubviews: arrangedSubviews)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}


extension UILabel {

    /// Returns a `UILabel` suitable for cells containing a "title".
    ///
    /// - Note: This font used by this label does __not__ require resetting when the content size category changes.
    ///
    /// - Parameter title: an optional default title.
    /// - Returns: a new "title" label.
    public static func makeDynamicTableViewCellTitleLabel(withTitle title: String? = nil) -> UILabel {
        let label = UILabel(font: .preferredFontForDynamicTableViewCellTitleLabel)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        label.isUserInteractionEnabled = true
        label.textColor = label.tintColor
        label.text = title

        return label
    }

    public convenience init(font: UIFont, text: String? = nil) {
        self.init()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontForContentSizeCategory = true

        self.font = font
        self.text = text
    }
}

extension UIFont {

    /// Returns a "preferred" `UIFont" with a `.subheadline` text style.
    /// This font should be used for cells that contain a "title".
    ///
    /// - Note: This font does __not__ require resetting when the content size category changes.
    public static var preferredFontForDynamicTableViewCellTitleLabel: UIFont {
        return .preferredFont(forTextStyle: .subheadline)
    }
}


extension NSLayoutConstraint {

    public func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
