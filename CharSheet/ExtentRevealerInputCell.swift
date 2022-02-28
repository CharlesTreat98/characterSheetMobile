import UIKit

class ExtentRevealerInputCell: UITableViewCell {

    lazy var stackView = self.lazyStackView()
    lazy var textField = self.lazyTextField()
    lazy var label = self.lazyLabel()

    init(with labelText: String) {
        super.init(style: .default, reuseIdentifier: "cellIdentifier")

        label.attributedText = NSAttributedString(string: labelText)

        contentView.addSubview(stackView)
        stackView.constrain(toGuide: contentView.layoutMarginsGuide)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ExtentRevealerInputCell {

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
