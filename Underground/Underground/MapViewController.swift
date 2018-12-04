//
//  mapViewController.swift
//  Underground
//
//  Created by Joey Park on 11/29/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var createAlertButton: UIButton!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var currentLocation : CLLocationCoordinate2D? = nil
    var listOfStations : NSMutableArray = []
    var listOfComments : NSMutableArray = ["There's a 20 min delay","someone fell in the tracks"]
    let LTrainStations  = [["Lorimer St", "-73.95024799996972" , "40.71407200064717", "L", "L-all times" ]
        , ["Sutter Ave", "-73.9019160004208", "40.66914500061398", "L", "L-all times" ]
        , ["Wilson Ave", "-73.90395860491864", "40.68886654246024", "L", "L-all times" ],
          ["1st Ave", "-73.98168087489128", "40.73097497580066", "L", "L-all times" ],
          [ "Grand St", "-73.94049699874644", "40.71157600064823", "L", "L-all times" ]
        , ["Graham Ave", "-73.94394399869037", "40.714575998363635", "L", "L-all times" ]
        , ["Bedford Ave", "-73.95666499806525", "40.71717399858899", "L", "L-all times" ]
        , ["Montrose Ave", "-73.93979284713505", "40.70739106438455", "L", "L-all times" ],
          ["Atlantic Ave", "-73.9030969995401", "40.67534466640805", "L", "L-all times" ],
          ["Halsey St", "-73.90393400118631", "40.69551800114878", "L", "L-all times" ]
        , ["Myrtle - Wyckoff Aves", "-73.9109757182647", "40.699471062427136", "L", "L-all times" ],
          ["Livonia Ave", "-73.90056237226057", "40.66405727094644", "L", "L-all times" ],
          ["Canarsie - Rockaway Pkwy", "-73.90185000017287", "40.64665366739528", "L", "L-all times" ]
        , ["E 105th St", "-73.89954769388724", "40.65046878544699", "L", "L-all times" ],
          ["New Lots Ave", "-73.89927796057142", "40.65891477368527", "L", "L-all times" ],
          ["DeKalb Ave", "-73.91823200219723", "40.70369299961644", "L", "L-all times" ],
          ["Bushwick - Aberdeen", "-73.90526176305106", "40.68286062551184", "L", "L-all times" ]
        , ["Broadway Junction", "-73.90311757920684", "40.67845624842869", "L", "L-all times" ],
          ["Jefferson St", "-73.9229130000312", "40.706606665988716", "L", "L-all times" ]
        , ["Morgan Ave", "-73.93314700024209", "40.70615166680729", "L", "L-all times" ],
          ["3rd Ave", "-73.98575000112093", "40.73269099971662", "L", "L-all times" ]
        , ["Union Sq - 14th St", "-73.99066976901818", "40.73476331217923", "L", "L-all times" ],
          ["6th Ave", "-73.99775078874781", "40.73774146981052", "L", "L-all times" ]
        , ["8th Ave", "-74.00257800104762", "40.73977666638199", "L", "L-all times" ]]
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        self.commentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        for LTrainStation in LTrainStations{
            let station = MKPointAnnotation.init()
            station.coordinate = CLLocationCoordinate2D.init(latitude: Double(LTrainStation[2])!, longitude: Double(LTrainStation[1])!)
            station.title = LTrainStation[0]
            mapView.addAnnotation(station)
        }
        
        commentsTableView.isHidden = true
        createAlertButton.isHidden = true
        createAlertButton.isEnabled = false
        view.bringSubviewToFront(createAlertButton)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        commentsTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        if touch?.view != commentsTableView && touch?.view != createAlertButton {
            commentsTableView.isHidden = true
            createAlertButton.isHidden = true
            createAlertButton.isEnabled = false
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        commentsTableView.isHidden = false
        createAlertButton.isHidden = false
        createAlertButton.isEnabled = true
    }
    
    @IBAction func goToCreateAlertView(_ sender: Any) {
        self.storyboard?.instantiateViewController(withIdentifier: "CreateAlertViewController")
    }
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
        centerMapOnUserLocation()
    }
    
    func centerMapOnUserLocation() {
        let coordinateRegion = MKCoordinateRegion(center: currentLocation!, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let alerts = StationAlerts.getInstance()
        return alerts.listOfAlerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let alerts = StationAlerts.getInstance()
        let comment = alerts.listOfAlerts[indexPath.row]
        cell.textLabel?.text = (comment as! String)
        
        return cell
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
