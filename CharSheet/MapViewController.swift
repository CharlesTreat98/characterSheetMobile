//
//  MapViewController.swift
//  CharSheet
//
//  Created by Charlie Treat on 6/21/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView: MKMapView?

    var characterLocation: CharacterCreation?

    var extentCache: [Double] = []

    init(characterLocation: CharacterCreation?) {
        self.characterLocation = characterLocation

        super.init(nibName: nil, bundle: nil)

        guard let characterLocation = characterLocation else {
            return
        }

        extentCache = [
            characterLocation.coordinate.latitude,
            characterLocation.coordinate.longitude,
            0.51,
            1.0
        ]

        applyCache()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let window = UIWindow(frame: UIScreen.main.bounds)

        self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: window.frame.width, height: window.frame.height))

        view.addSubview(mapView!)

        if let characterLocation = characterLocation {
            mapView?.addAnnotation(characterLocation)
        }
        
//        fileprivate mapView = MKMapView(
        
        // Do any additional setup after loading the view.

        setUpBarButtonItem()

        guard characterLocation != nil else {
            return
        }

        applyCache()
    }

    private func setUpBarButtonItem() {
        let presentAction = UIAction(handler: {_ in self.showExtentRevealer()})

        let barButtonItem  = UIBarButtonItem(image: UIImage(systemName: "bookmark"), primaryAction: presentAction)

        navigationItem.rightBarButtonItem = barButtonItem
    }
    

    /*
    // MARK: - Navigation
    */

    @objc
    private func showExtentRevealer() {
        presentModally(ExtentRevealerViewController(presentingViewController: self))
    }

    private func applyCache() {
        if !extentCache.isEmpty {
            mapView?.setRegion(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: extentCache[0],
                        longitude: extentCache[1]
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: extentCache[2],
                        longitudeDelta: extentCache[3]
                    )
                ),
                animated: true
            )
        }
    }
}
