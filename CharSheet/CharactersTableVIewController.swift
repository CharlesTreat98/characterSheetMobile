import UIKit
import CoreLocation


final class CharactersTableVIewController: UITableViewController {

    private lazy var editItem: UIBarButtonItem = lazyEditItem()

    var characterCollection: CharacterCollection = CharacterCollection(characterSheets: [
        CharacterSheet(hitPoints: 66, level: 6, name: "Kitt", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 66,  attackMod: 7, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)),
        CharacterSheet(hitPoints: 18, level: 1, name: "Mark_IV", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 18, attackMod: 5, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10), creationCoordinate: CLLocationCoordinate2D(latitude: 47.9032, longitude: -91.8671)),
        CharacterSheet(hitPoints: 44, level: 20, name: "Ba'alzamon", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 44, attackMod: 22, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)),
        CharacterSheet(hitPoints: 120, level: 12, name: "Moiraine", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 120, attackMod: 11, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)),
        CharacterSheet(hitPoints: 35, level: 5, name: "Varjo", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 35, attackMod: 6, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)),
        CharacterSheet(hitPoints: 96, level: 10, name: "Fuyuki", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 96, attackMod: 10, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10), creationCoordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)),
        CharacterSheet(hitPoints: 44, level: 5, name: "Tasbard", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 44, attackMod: 7, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10),  creationCoordinate: CLLocationCoordinate2D(latitude: 44.9747, longitude: -92.7569)),
        CharacterSheet(hitPoints: 70, level: 6, name: "Eloise", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 70, attackMod: 8, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10), creationCoordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)),
        CharacterSheet(hitPoints: 58, level: 6, name: "Harenhalleth", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 58, attackMod: 8, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10), creationCoordinate: CLLocationCoordinate2D(latitude: 44.9747, longitude: -92.7569)),
        CharacterSheet(hitPoints: 78, level: 9, name: "Cosmo", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 78, attackMod: 12, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)),
        CharacterSheet(hitPoints: 22, level: 4, name: "Neldor", dateCreated:  Date(timeIntervalSince1970: TimeInterval(55)), currentHitPoints: 22, attackMod: 7, characterStats: CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10), creationCoordinate: CLLocationCoordinate2D(latitude: 42.041505, longitude: -91.651223))
    ])

    var characterCells: [CustomCharacterCellTableViewCell] {
        return characterCollection.characterSheets.map { sheet in
            let cell = CustomCharacterCellTableViewCell(style: .default, reuseIdentifier: String(describing: CustomCharacterCellTableViewCell.self))
            cell.render(with: sheet)
            return cell
        }
    }
}

extension CharactersTableVIewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.register(CustomCharacterCellTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }

    override func viewDidLayoutSubviews() {
        navigationItem.rightBarButtonItem = editItem
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characterCells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return characterCells[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let charSheet = CharacterSheetViewViewController(nibName: "CharacterSheetViewViewController", bundle: nil)
        charSheet.currentChar = characterCollection.characterSheets[indexPath.row]

        navigationController?.show(charSheet, sender: self)

    }
}

extension CharactersTableVIewController {

    func add(characterSheet: CharacterSheet) {
        characterCollection.characterSheets.append(characterSheet)
        tableView.performBatchUpdates({
            self.tableView.insertRows(
                at: [IndexPath(row: self.characterCollection.characterSheets.count - 1,section: 0)],
                with: .automatic)
        }, completion: nil)
    }
}

extension CharactersTableVIewController {

    private func lazyEditItem() -> UIBarButtonItem {
        let plusImage = UIImage(systemName: "plus")

        let editAction = UIAction(handler: { [weak self] _ in
            guard let self = self else {
                return
            }

            self.presentModally(CharacterAdditionViewController(presentingCharacterViewController: self))
        })

        let editButtonItem = UIBarButtonItem(image: plusImage, primaryAction: editAction)
        return editButtonItem
    }
}
