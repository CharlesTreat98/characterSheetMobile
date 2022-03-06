import UIKit

class InputTableViewCell: UITableViewCell, InputCellValueProvider {

    lazy var stackView = self.lazyStackView()
    lazy var textField = self.lazyTextField()
    lazy var label = self.lazyLabel()

    var key: String? {
        return label.text
    }

    var currentValue: String? {
        return textField.text
    }

    init(with labelText: String) {
        super.init(style: .default, reuseIdentifier: "cellIdentifier")

        label.attributedText = NSAttributedString(string: labelText)

        selectionStyle = .none

        contentView.addSubview(stackView)
        stackView.constrain(toGuide: contentView.layoutMarginsGuide)
    }

    required init?(coder: NSCoder) {
        preconditionFailure()
    }
}

extension InputTableViewCell {

    fileprivate func lazyStackView() -> UIStackView {

        let stackView = UIStackView(
            arrangedSubviews: [label, textField],
            axis: .vertical,
            alignment: .fill,
            distribution: .fill,
            spacing: 2.0
        )

        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.setContentHuggingPriority(.required, for: .vertical)

        return stackView
    }

    fileprivate func lazyLabel() -> UILabel {
        return .makeDynamicTableViewCellTitleLabel()
    }

    fileprivate func lazyTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.adjustsFontForContentSizeCategory = true
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentHuggingPriority(.required, for: .vertical)

        textField.font = .preferredFont(forTextStyle: .body)

        return textField
    }
}
