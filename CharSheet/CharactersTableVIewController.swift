import UIKit
import CoreLocation


final class CharactersTableVIewController: UITableViewController {

    private lazy var editItem: UIBarButtonItem = lazyEditItem()

    var defaultStats: CharacterStats {
        return CharacterStats(strength: 10, constitution: 10, dexterity: 10, wisdom: 10, intelligence: 10, charisma: 10)
    }

    var newDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(55))
    }

    var characters: [CharacterSheet] = []
}

extension CharactersTableVIewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        characters = [
            CharacterSheet(hitPoints: 66, level: 6, name: "Kitt", dateCreated: newDate, currentHitPoints: 66,  attackMod: 7, characterStats: defaultStats),
            CharacterSheet(hitPoints: 18, level: 1, name: "Mark_IV", dateCreated: newDate, currentHitPoints: 18, attackMod: 5, characterStats: defaultStats, creationCoordinate: CLLocationCoordinate2D(latitude: 47.9032, longitude: -91.8671)),
            CharacterSheet(hitPoints: 44, level: 20, name: "Ba'alzamon", dateCreated: newDate, currentHitPoints: 44, attackMod: 22, characterStats: defaultStats),
            CharacterSheet(hitPoints: 120, level: 12, name: "Moiraine", dateCreated: newDate, currentHitPoints: 120, attackMod: 11, characterStats: defaultStats),
            CharacterSheet(hitPoints: 35, level: 5, name: "Varjo", dateCreated: newDate, currentHitPoints: 35, attackMod: 6, characterStats: defaultStats),
            CharacterSheet(hitPoints: 96, level: 10, name: "Fuyuki", dateCreated: newDate, currentHitPoints: 96, attackMod: 10, characterStats: defaultStats, creationCoordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)),
            CharacterSheet(hitPoints: 44, level: 5, name: "Tasbard", dateCreated: newDate, currentHitPoints: 44, attackMod: 7, characterStats: defaultStats,  creationCoordinate: CLLocationCoordinate2D(latitude: 44.9747, longitude: -92.7569)),
            CharacterSheet(hitPoints: 70, level: 6, name: "Eloise", dateCreated: newDate, currentHitPoints: 70, attackMod: 8, characterStats: defaultStats, creationCoordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298)),
            CharacterSheet(hitPoints: 58, level: 6, name: "Harenhalleth", dateCreated: newDate, currentHitPoints: 58, attackMod: 8, characterStats: defaultStats, creationCoordinate: CLLocationCoordinate2D(latitude: 44.9747, longitude: -92.7569)),
            CharacterSheet(hitPoints: 78, level: 9, name: "Cosmo", dateCreated: newDate, currentHitPoints: 78, attackMod: 12, characterStats: defaultStats),
            CharacterSheet(hitPoints: 22, level: 4, name: "Neldor", dateCreated: newDate, currentHitPoints: 22, attackMod: 7, characterStats: defaultStats, creationCoordinate: CLLocationCoordinate2D(latitude: 42.041505, longitude: -91.651223))
        ]


        tableView.register(CustomCharacterCellTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")

    }

    override func viewDidLayoutSubviews() {
        navigationItem.rightBarButtonItem = editItem
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        cell.textLabel?.text = characters[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "Headline", size: 20.0)
        cell.detailTextLabel?.text = "Level: " + String(characters[indexPath.row].level)
        
        cell.detailTextLabel?.textAlignment = .right
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let charSheet = CharacterSheetViewViewController(nibName: "CharacterSheetViewViewController", bundle: nil)
        charSheet.currentChar = characters[indexPath.row]

        navigationController?.show(charSheet, sender: self)

    }
}

extension CharactersTableVIewController {

    private func lazyEditItem() -> UIBarButtonItem {
        let plusImage = UIImage(systemName: "plus")

        let editAction = UIAction(handler: { [weak self] _ in
            self?.presentModally(CharacterAdditionViewController(presentingCharacterViewController: self!))
        })

        let editButtonItem = UIBarButtonItem(image: plusImage, primaryAction: editAction)
        return editButtonItem
    }
}
