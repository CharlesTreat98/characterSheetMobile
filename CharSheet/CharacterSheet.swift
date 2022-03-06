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


final class CharacterSheet: Identifiable, Comparable {
    
    var id = UUID()
    public var hitPoints: Int
    public var level: Int
    public var name: String
    public var dateCreated: Date
    public var currentHitPoints: Int
    // Attack mod cannot be negative
    public var attackMod: Int
    public var creationCoordinate: CLLocationCoordinate2D? = nil

    public var characterStats: CharacterStats

    init(
        hitPoints: Int,
        level: Int,
        name: String,
        dateCreated: Date,
        currentHitPoints: Int,
        attackMod: Int,
        characterStats: CharacterStats,
        creationCoordinate: CLLocationCoordinate2D? = nil
    ) {
        self.hitPoints = hitPoints
        self.level = level
        self.name = name
        self.dateCreated = dateCreated
        self.currentHitPoints = currentHitPoints
        self.attackMod = attackMod
        self.characterStats = characterStats
        self.creationCoordinate = creationCoordinate
    }
    
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

extension CharacterSheet {

    static func == (lhs: CharacterSheet, rhs: CharacterSheet) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: CharacterSheet, rhs: CharacterSheet) -> Bool {
        return lhs.name < rhs.name
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
