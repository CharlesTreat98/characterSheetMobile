//
//  CharacterStatTableViewCell.swift
//  CharSheet
//
//  Created by Charlie Treat on 3/6/22.
//

import UIKit

class CharacterStatTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, InputCellValueProvider {

    lazy var pickerView: UIPickerView = createSDCWICSelectionRow()
    lazy var label = self.createLabel()

    var key: String? {
        return label.text
    }

    var currentValue: String? {
        return pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
    }

    init(stat: CharacterStats.Label) {
        super.init(style: .default, reuseIdentifier: String(describing: CharacterStatTableViewCell.self))

        label.text = stat.rawValue

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        selectionStyle = .none

        contentView.addSubview(label)
        contentView.addSubview(pickerView)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor),
            label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            pickerView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pickerView.heightAnchor.constraint(lessThanOrEqualToConstant: 55)

        ])
    }

    func render(stat: CharacterStats.Label) {
        label.text = stat.rawValue
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
        return .makeDynamicTableViewCellTitleLabel()
    }
}
