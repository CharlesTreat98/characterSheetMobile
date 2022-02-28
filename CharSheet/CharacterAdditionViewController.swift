//
//  CharacterAdditionViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 2/27/22.
//
import Foundation
import UIKit

final class CharacterAdditionViewController: UIViewController {

    let characterSheet: CharacterSheet

    init(characterSheet: CharacterSheet) {
        self.characterSheet = characterSheet

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        preconditionFailure()
    }
}

extension CharacterAdditionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    private func createSDCWICRow(for stat: CharacterStats) -> UIStackView {
        let label = createLabel(for: stat.rawValue)

        let numberPicker = UIPickerView()

        numberPicker.delegate = StatBlockPickerDataSource(update: { newValue in
            

        })

    }

    private func createLabel(for text: String) -> UILabel {
        return UILabel(font: .preferredFont(forTextStyle: .headline), text: text)
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
