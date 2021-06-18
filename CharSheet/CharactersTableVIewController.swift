//
//  CharactersTableVIewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/15/21.
//

import UIKit

final class CharactersTableVIewController: UITableViewController {

    let characters = [
        JeanV,
        Yanko,
        Rand,
        CharacterSheet(hitPoints: 66, level: 6, name: "Kitt", dateCreated: newDate, currentHitPoints: 66,  attackMod: 7),
        CharacterSheet(hitPoints: 18, level: 1, name: "Mark 4", dateCreated: newDate, currentHitPoints: 18, attackMod: 5),
        CharacterSheet(hitPoints: 44, level: 20, name: "Ba'alzamon", dateCreated: newDate, currentHitPoints: 44, attackMod: 22),
        CharacterSheet(hitPoints: 120, level: 12, name: "Moiraine", dateCreated: newDate, currentHitPoints: 120, attackMod: 11),
        CharacterSheet(hitPoints: 35, level: 5, name: "Varjo", dateCreated: newDate, currentHitPoints: 35, attackMod: 6),
        CharacterSheet(hitPoints: 96, level: 10, name: "Fuyuki", dateCreated: newDate, currentHitPoints: 96, attackMod: 10),
        CharacterSheet(hitPoints: 44, level: 5, name: "Tasbard", dateCreated: newDate, currentHitPoints: 44, attackMod: 7),
        CharacterSheet(hitPoints: 70, level: 6, name: "Eloise", dateCreated: newDate, currentHitPoints: 70, attackMod: 8),
        CharacterSheet(hitPoints: 58, level: 6, name: "Harenhalleth", dateCreated: newDate, currentHitPoints: 58, attackMod: 8),
        CharacterSheet(hitPoints: 78, level: 9, name: "Cosmo", dateCreated: newDate, currentHitPoints: 78, attackMod: 12),
        CharacterSheet(hitPoints: 60, level: 7, name: "Ishmael", dateCreated: newDate, currentHitPoints: 60, attackMod: 9)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")

        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        }
        
        
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
//         Configure the cell...
        
        

        cell!.textLabel?.text = characters[indexPath.row].name
        cell!.detailTextLabel?.text = "Level: " + String(characters[indexPath.row].level)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: "char://" + characters[indexPath.row].name) {
//            UIApplication.shared.open(url)
            print("going to \(characters[indexPath.row].name)'s page. \(url)")
            
            let charSheet = CharacterSheetViewViewController(nibName: "CharacterSheetViewViewController", bundle: nil)
            charSheet.currentChar = characters[indexPath.row]
            
            navigationController?.pushViewController(charSheet, animated: true)
            
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
