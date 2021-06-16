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
    @IBOutlet weak var hitStatus:UILabel?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        textLabel?.text = currentChar.name
        textLabel2?.text = "Level: " + String(currentChar.level) + "\n" +
                          "Hitpoints: " + String(currentChar.hitPoints) + "\n" +
                          "Attack Modifier: " + String(currentChar.attackMod) + "\n" +
                            "Date Created: " +  dateFormatter.string(from: currentChar.dateCreated)
        hitStatus?.text = ""
        
        textLabel2?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        hitButton?.setTitle("Roll to Hit the Goblin!", for: .normal)
//        hitButton?.addAction(self.determineHit(), for: hitButton?.isHighlighted)
        hitButton?.addTarget(self, action: #selector(determineHit(sender:)), for: .touchUpInside)
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func determineHit(sender: UIButton) {
        
        if (currentChar.toHit()) {
            hitStatus?.text = ("You hit the goblin! Hit it again?")
        }
        else {
            hitStatus?.text = ("You missed the goblin!")
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
