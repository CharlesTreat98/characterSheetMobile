//
//  CharacterSheetViewViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/16/21.
//

import UIKit
import MapKit

final class CharacterSheetViewViewController: UIViewController {

    var currentChar: CharacterSheet = CharacterSheet(hitPoints: 0, level: 0, name: "", dateCreated: Date(), currentHitPoints: 0, attackMod: 0)
    
    
    @IBOutlet weak var textLabel:UILabel?
    @IBOutlet weak var textLabel2:UITextView?
    @IBOutlet weak var hitButton:UIButton?
    @IBOutlet weak var hitStatus:UITextView?
    
    let charMenu: UIMenuController = .shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarButtonItem()
        
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
        
        hitStatus?.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        hitButton?.setTitle("Roll to Hit the Goblin!", for: .normal)
//        hitButton?.addAction(self.determineHit(), for: hitButton?.isHighlighted)
//        hitButton?.addTarget(self, action: #selector(determineHit(sender:)), for: .touchUpInside)
        
        
        
        // Do any additional setup after loading the view.

        let toolBar = UIToolbar()

        let label = UILabel(font: .preferredFont(forTextStyle: .headline), text: "Testing The Font")

        label.adjustsFontForContentSizeCategory = true

        let toolbarButtonItem = UIBarButtonItem(customView: label)
        toolBar.items = [toolbarButtonItem]
        toolBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(toolBar)

        NSLayoutConstraint.activate([
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }
    
    private func setupBarButtonItem() {
        let attackAction = UIAction(title: "Attack the goblin!", image: UIImage(systemName: "die.face.6")) { action in self.determineHit()}
        let hitByGoblin = UIAction(title: "Hit by the goblin!", image: UIImage(systemName: "exclamationmark.shield")) { action in self.hitByGob() }
        let drinkHealingPotion =  UIAction(title: "Drink a healing potion!", image: UIImage(systemName: "drop.triangle")) { action in self.takeHealingPotion() }
        
        let openNav = UIAction(title: "Open map") { action in self.showMapView() }
        
            
        
        let charMenu = UIMenu(title: "\(currentChar.name) menu", children: [
            attackAction,
            hitByGoblin,
            drinkHealingPotion
        ])
        
        let navButton = UIBarButtonItem(image: UIImage(systemName: "location"), primaryAction: openNav)
        
        let charOptionsMenu = UIBarButtonItem(image: UIImage(systemName: "shield.lefthalf.fill"  ), menu: charMenu)
        
//        let charOptions = UIBarButtonItemGroup(barButtonItems: [navButton, charOptionsMenu], representativeItem: UIBarButtonItem(image: UIImage(systemName: "person")))
        
//        navigationItem.rightBarButtonItem = charOptions
        navigationItem.rightBarButtonItems = [navButton, charOptionsMenu]
        
    }
    
    @objc func showMapView() {

        let mapView = MapViewController(characterLocation: currentChar.characterCreationLocation())
//        navigationController?.show(MapViewController, sender: self)
        navigationController?.show(mapView, sender: self)
        
    }
    
    
    @objc func determineHit() {
        
        if (currentChar.toHit()) {
            hitStatus?.text = ("You hit the goblin! Hit it again?")
        }
        else {
            hitStatus?.text = ("You missed the goblin!")
        }
        
        
    }
    
    @objc func hitByGob()  {
        let dmg = (Int.random(in: 2...8))
        if( currentChar.currentHitPoints - dmg <= 0 ){
            hitStatus?.text = ("The goblin just killed \(currentChar.name)!")
            currentChar.currentHitPoints = 0
        }
        else {
            currentChar.currentHitPoints = currentChar.currentHitPoints - dmg
            hitStatus?.text = "The goblin hit you for \(dmg). \n  \(currentChar.name) has \(currentChar.currentHitPoints) hitpoints left"
        }
    }
    
    @objc func takeHealingPotion() {
        let hpHealed = Int.random(in: 4...8)
        currentChar.currentHitPoints = currentChar.currentHitPoints + hpHealed
        hitStatus?.text = "\(currentChar.name) was healed for \(hpHealed). They now have \(currentChar.currentHitPoints)"
            
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
