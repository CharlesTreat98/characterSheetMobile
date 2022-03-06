import Foundation
import UIKit
import MapKit

final class CharacterAdditionViewController: UITableViewController {

    private var statCells: [CharacterStatTableViewCell] = CharacterStats.Label.allCases.map { CharacterStatTableViewCell(stat: $0) }

    private let playerBasicInfo = [
        InputTableViewCell(with: "Name"),
        InputTableViewCell(with: "Level"),
        InputTableViewCell(with: "Class"),
        InputTableViewCell(with: "Hit Points")
    ]

    private var allRows: [InputCellValueProvider] {
        return playerBasicInfo + statCells
    }

    var presentingCharacterViewController: CharactersTableVIewController

    init(presentingCharacterViewController: CharactersTableVIewController) {
        self.presentingCharacterViewController = presentingCharacterViewController

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterAdditionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Character Creation"

        tableView.register(CharacterStatTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterStatTableViewCell.self))
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: String(describing: InputTableViewCell.self))
        // Do any additional setup after loading the view.

        setUpSubmitButton()
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

    private func setUpSubmitButton() {
        let action = UIAction { [weak self, presentingCharacterViewController] _ in
            guard let characterSheet = self?.createCharacterSheet()
            else {
                // Set up input validation
                return
            }

            presentingCharacterViewController.add(characterSheet: characterSheet)
            self?.navigationController?.dismiss(animated: true)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", primaryAction: action)
    }

    private func createCharacterSheet() -> CharacterSheet? {
        guard
            let hitpoints = (allRows.first { $0.key == "Hit Points"})?.currentValue,
            let intHp = Int(hitpoints),
            let level = (allRows.first { $0.key == "Level"})?.currentValue,
            let intLevel = Int(level),
            let name = (allRows.first { $0.key == "Name"})?.currentValue,
            let str = (allRows.first { $0.key == "Strength"})?.currentValue,
            let intStr = Int(str),
            let dex = (allRows.first { $0.key == "Dexterity"})?.currentValue,
            let intDex = Int(dex),
            let con = (allRows.first { $0.key == "Constitution"})?.currentValue,
            let intCon = Int(con),
            let int = (allRows.first { $0.key == "Intelligence"})?.currentValue,
            let intInt = Int(int),
            let chr = (allRows.first { $0.key == "Charisma"})?.currentValue,
            let intChr = Int(chr),
            let wis = (allRows.first { $0.key == "Wisdom"})?.currentValue,
            let intWis = Int(wis)
        else {
            return nil
        }

        return CharacterSheet(
            hitPoints: intHp,
            level: intLevel,
            name: name,
            dateCreated: Date(timeIntervalSince1970: 500.0),
            currentHitPoints: intHp,
            attackMod: 0,
            characterStats: CharacterStats(
                strength: intStr,
                constitution: intCon,
                dexterity: intDex,
                wisdom: intWis,
                intelligence: intInt,
                charisma: intChr
            ),
            creationCoordinate: nil
        )

    }
}
