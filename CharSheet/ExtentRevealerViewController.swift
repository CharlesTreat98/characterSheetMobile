import UIKit
import MapKit

class ExtentRevealerViewController: UITableViewController {

    let previousViewController: MapViewController

    init(presentingViewController: MapViewController) {
        self.previousViewController = presentingViewController

        super.init(nibName: nil, bundle: nil)

        self.setUpBarButtonItem()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ExtentRevealerInputCell.self, forCellReuseIdentifier: "cellIdentifier")
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = inputRows[indexPath.row]

        if !previousViewController.extentCache.isEmpty {
            row.textField.text = String(previousViewController.extentCache[indexPath.row])
        }

        return row
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputRows.count
    }


//    private func lazyStackView() ->
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private let inputRows = [
        ExtentRevealerInputCell(with: "Center Latitude"),
        ExtentRevealerInputCell(with: "Center Longitude"),
        ExtentRevealerInputCell(with: "Span Latitude Delta"),
        ExtentRevealerInputCell(with: "Span Longitude Delta")
    ]


    private func setUpBarButtonItem() {
        let action = UIAction(handler: { [weak self] _ in
            let centerLatText = self?.inputRows[0].textField.text
            let centerLong = self?.inputRows[1].textField.text
            let spanLatDelta = self?.inputRows[2].textField.text
            let spanLongDelta = self?.inputRows[3].textField.text


            guard let centerLatDouble = Double(centerLatText!),
                  let centerLongDouble = Double(centerLong!),
                  let spanLatDeltaDouble = Double(spanLatDelta!),
                  let spanLongDeltaDouble = Double(spanLongDelta!)
            else {
                return
            }


            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: centerLatDouble, longitude: centerLongDouble),
                span: MKCoordinateSpan(latitudeDelta: spanLatDeltaDouble, longitudeDelta: spanLongDeltaDouble)
            )

//            let mapViewController = MapViewController(characterLocation: nil)

            self?.previousViewController.extentCache = [centerLatDouble, centerLongDouble, spanLatDeltaDouble, spanLongDeltaDouble]
            self?.previousViewController.mapView!.setRegion(region, animated: true)
            self?.presentingViewController!.dismiss(animated: true)
        })


        let submitButton = UIBarButtonItem(title: "Submit", primaryAction: action)

        navigationItem.rightBarButtonItem = submitButton
    }
}
