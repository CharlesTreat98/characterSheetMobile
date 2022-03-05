//
//  CharacterAdditionViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 2/27/22.
//
import Foundation
import UIKit

final class CharacterAdditionViewController: UITableViewController {

}

extension CharacterAdditionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterStatCell.self, forCellReuseIdentifier: String(describing: CharacterStatCell.self))
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    private var statRows: [CharacterStats.Label] {
        return CharacterStats.Label.allCases
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterStatCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterStatCell.self), for: indexPath) as! CharacterAdditionViewController.CharacterStatCell
        cell.render(stat: statRows[indexPath.row])
        cell.pickerView.reloadAllComponents()
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CharacterAdditionViewController {

    class CharacterStatCell: UITableViewCell {

        lazy var pickerView: UIPickerView = createSDCWICSelectionRow()
        lazy var label = self.createLabel()
        lazy var stackView = self.lazyStackView()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func render(stat: CharacterStats.Label) {
            label.text = stat.rawValue

            stackView.setContentCompressionResistancePriority(.required, for: .vertical)

            contentView.addSubview(stackView)
            stackView.constrain(to: contentView)
        }

        private func createSDCWICSelectionRow() -> UIPickerView {

            let numberPicker = UIPickerView()

            let dataSource = StatBlockPickerDataSource(update: { newValue in

            })

            numberPicker.delegate = dataSource
            numberPicker.dataSource = dataSource

            numberPicker.selectRow(10, inComponent: 0, animated: false)

            numberPicker.backgroundColor = .systemBackground
            numberPicker.translatesAutoresizingMaskIntoConstraints = false

            return numberPicker
        }

        private func lazyStackView() -> UIStackView {
            let stackView = UIStackView(
                arrangedSubviews: [label, pickerView],
                axis: .vertical,
                alignment: .leading,
                distribution: .fillEqually
            )

            stackView.setContentCompressionResistancePriority(.required, for: .vertical)

            return stackView
        }

        private func createLabel() -> UILabel {
            return UILabel(font: .preferredFont(forTextStyle: .headline), text: "")
        }
    }
}

extension CharacterAdditionViewController {

    class StatBlockPickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

        let update: (Int) -> Void

        init(update: @escaping (Int) -> Void) {
            self.update = update
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 20
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadAllComponents()

            update(row)
        }
    }
}
