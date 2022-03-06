import UIKit
/// This protocol allows developers to easily access the value from various types of input cells.
protocol InputCellValueProvider: UITableViewCell {

    var key: String? { get }

    var currentValue: String? { get }
}
