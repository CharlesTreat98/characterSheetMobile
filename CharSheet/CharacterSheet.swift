//
//  CharacterSheet.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/15/21.
//

import Foundation


struct CharacterSheet: Identifiable, Comparable {
    static func < (lhs: CharacterSheet, rhs: CharacterSheet) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id = UUID()
    public var hitPoints: Int
    public var level: Int
    public var name: String
    public var dateCreated: Date
    public var currentHitPoints: Int
    // Attack mod cannot be negative
    public var attackMod: Int
    
    func toHit() -> Bool {
        let Num = Int.random(in: 1...20) + self.attackMod
        switch Num {
        case 1...11:
            return false
        default:
            return true
        }
    }
}


//let date_str = "14/06/2021"
//let dateFormatter = DateFormatter()
//
//dateFormatter.dateFormat = "dd/MM/yy"
//var newDate = dateFormatter.date(from: date_str)
var newDate = Date()

var JeanV = CharacterSheet(hitPoints: 22, level: 3, name: "Jean", dateCreated: newDate, currentHitPoints: 22, attackMod: 2)

var Yanko = CharacterSheet(hitPoints: 100, level: 9, name: "Yanko", dateCreated: newDate, currentHitPoints: 100, attackMod: 8)

var Rand = CharacterSheet(hitPoints: 58, level: 3, name: "Rand", dateCreated: newDate, currentHitPoints: 58, attackMod: 4)
//
//
//let characters: [CharacterSheet] =
//    [JeanV, Yanko, Rand,
//     CharacterSheet(hitPoints: 66, level: 6, name: "Kitt", dateCreated: newDate, attackMod: 7),
//     CharacterSheet(hitPoints: 18, level: 1, name: "Mark 4", dateCreated: newDate, attackMod: 5),
//     CharacterSheet(hitPoints: 44, level: 20, name: "Ba'alzamon", dateCreated: newDate, attackMod: 22),
//     CharacterSheet(hitPoints: 120, level: 12, name: "Moiraine", dateCreated: newDate, attackMod: 11),
//     CharacterSheet(hitPoints: 35, level: 5, name: "Varjo", dateCreated: newDate, attackMod: 6),
//     CharacterSheet(hitPoints: 96, level: 10, name: "Fuyuki", dateCreated: newDate, attackMod: 10),
//     CharacterSheet(hitPoints: 44, level: 5, name: "Tasbard", dateCreated: newDate, attackMod: 7)]
