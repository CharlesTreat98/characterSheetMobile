//
//  CharacterSheetViewViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/16/21.
//

import UIKit

class CharacterSheetViewViewController: UIViewController {

    var currentChar: CharacterSheet = CharacterSheet(hitPoints: 0, level: 0, name: "", dateCreated: Date(), attackMod: 0)
    
    @IBOutlet weak var textLabel:UILabel?
    @IBOutlet weak var textLabel2:UITextView?
    @IBOutlet weak var hitButton:UIButton?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        textLabel?.text = currentChar.name
        textLabel2?.text = "Level: " + String(currentChar.level) + "\n" +
                          "Hitpoints: " + String(currentChar.hitPoints) + "\n" +
                            "Date Created: " +  dateFormatter.string(from: currentChar.dateCreated)
                        
        
        hitButton?.setTitle("Roll to Hit the Goblin!", for: .normal)
//        hitButton?.addAction(self.determineHit(), for: hitButton?.isHighlighted)
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    func determineHit() {
        
        if (currentChar.toHit()) {
            hitButton?.setTitle("You hit the goblin! Hit it again?", for: .normal)
        }
        else {
            hitButton?.setTitle("You missed the goblin!", for: .disabled)
        }
        
        
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
