import UIKit
import MapKit

class CharacterCreation: NSObject, MKAnnotation {

    let coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
