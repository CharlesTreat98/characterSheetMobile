//
//  CharacterAdditionViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 2/27/22.
//
import Foundation
import UIKit

final class CharacterAdditionViewController: UITableViewController {


    private var statCells: [CharacterStatCell] = CharacterStats.Label.allCases.map { CharacterStatCell(stat: $0) }

    private let playerBasicInfo = [
        InputTableViewCell(with: "Name"),
        InputTableViewCell(with: "Level"),
        InputTableViewCell(with: "Class"),
        InputTableViewCell(with: "Hitpoints")
    ]

    private var allRows: [UITableViewCell] {
        return playerBasicInfo + statCells
    }
}

extension CharacterAdditionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Character Creation"

        tableView.register(CharacterStatCell.self, forCellReuseIdentifier: String(describing: CharacterStatCell.self))
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: String(describing: InputTableViewCell.self))
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return allRows[indexPath.row]
    }
}

extension CharacterAdditionViewController {

    class CharacterStatCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

        lazy var pickerView: UIPickerView = createSDCWICSelectionRow()
        lazy var label = self.createLabel()

        var currentValue: String? {
            return pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
        }

        private var update: ((Int) -> Void)?

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            configure()
        }

        init(stat: CharacterStats.Label) {
            super.init(style: .default, reuseIdentifier: String(describing: CharacterStatCell.self))

            label.text = stat.rawValue

            configure()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func configure() {

            contentView.addSubview(label)
            contentView.addSubview(pickerView)

            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
                label.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
                label.topAnchor.constraint(equalTo: contentView.topAnchor),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                pickerView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
                pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                pickerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                pickerView.heightAnchor.constraint(lessThanOrEqualToConstant: 55)

            ])
        }

        func render(stat: CharacterStats.Label, update: @escaping (Int) -> Void) {
            label.text = stat.rawValue
            self.update = update
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(row + 1)
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 20
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadAllComponents()

            update?(row)
        }

        private func createSDCWICSelectionRow() -> UIPickerView {

            let numberPicker = UIPickerView()

            numberPicker.delegate = self
            numberPicker.dataSource = self

            numberPicker.selectRow(9, inComponent: 0, animated: false)

            numberPicker.backgroundColor = .systemBackground
            numberPicker.translatesAutoresizingMaskIntoConstraints = false

            return numberPicker
        }

        private func createLabel() -> UILabel {
            return UILabel(font: .preferredFont(forTextStyle: .headline), text: "")
        }
    }
}
