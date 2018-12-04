//
//  CreateAlertViewController.swift
//  Underground
//
//  Created by Joey Park on 11/29/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

class CreateAlertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LTrainStations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LTrainStations[row][0]
    }
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var StationPickerView: UIPickerView!
    @IBOutlet weak var AlertTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StationPickerView.delegate = self
        StationPickerView.dataSource = self
        //self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        let alerts = StationAlerts.getInstance()
        guard let alert = AlertTextField.text, alert != "" else{
            print("alert was empty")
            return
        }
        alerts.listOfAlerts.add(alert)
        self.dismiss(animated: true, completion: nil)
        
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
