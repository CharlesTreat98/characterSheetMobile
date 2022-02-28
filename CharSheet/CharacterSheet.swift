//
//  CharacterSheet.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/15/21.
//

import Foundation
import MapKit
import CoreLocation
import MapKit


final class CharacterSheet: AnyObject, Identifiable, Comparable {
    static func == (lhs: CharacterSheet, rhs: CharacterSheet) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: CharacterSheet, rhs: CharacterSheet) -> Bool {
        return lhs.name < rhs.name
    }
    
    var id = UUID()
    public var hitPoints: Int
    public var level: Int
    public var name: String
    public var dateCreated: Date
    public var currentHitPoints: Int
//    public var createdCoordinates?: CLLocation
    // Attack mod cannot be negative
    public var attackMod: Int
    public var creationCoordinate: CLLocationCoordinate2D? = nil

    

    init(
        hitPoints: Int,
        level: Int,
        name: String,
        dateCreated: Date,
        currentHitPoints: Int,
        attackMod: Int,
        creationCoordinate: CLLocationCoordinate2D? = nil
    ) {
        self.hitPoints = hitPoints
        self.level = level
        self.name = name
        self.dateCreated = dateCreated
        self.currentHitPoints = currentHitPoints
        self.attackMod = attackMod
        self.creationCoordinate = creationCoordinate
    }
//    public var lat: Float
//    public var long: Float
//
//    init(hitPoints: Int, level: Int, name: String, dateCreated: Date, currentHitPoints: Int, attackMod: Int, lat: Float? = 21.282778, long: Float? = -157.829444) {
//        self.hitPoints = hitPoints
//        self.level = level
//        self.name = name
//        self.dateCreated = dateCreated
//        self.currentHitPoints = currentHitPoints
//        self.attackMod = attackMod
//        self.lat = lat!
//        self.long = long!
//    }
    
    func toHit() -> Bool {
        let Num = Int.random(in: 1...20) + self.attackMod
        switch Num {
        case 1...11:
            return false
        default:
            return true
        }
    }

    func characterCreationLocation() -> CharacterCreation? {
        if let creationCoordinate = creationCoordinate {
            return CharacterCreation(coordinate: creationCoordinate)
        } else {
            return nil
        }
    }

}

//extension CharacterSheet {
//    public var lat: Float
//    public var long: Float
//
//}


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


extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
