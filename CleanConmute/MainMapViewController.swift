//
//  FirstViewController.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/27/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController, MKMapViewDelegate {
    
//    struct SearchBar{
//        static let originX : CGFloat = 20.0
//        static let originY : CGFloat = 20.0
//        static var origin : CGPoint {
//            return CGPoint(x: originX, y: originY)
//        }
//    }
    
    @IBOutlet weak var sizer : UIStackView!
    @IBOutlet weak var mapView : MKMapView!
    weak var inScopeTextField : UITextField?
    var originTrip : String?{
        didSet{
            if originTrip?.count == 0 {
                originTrip = nil
            }
            searchArea?.from?.text = originTrip
        }
    }
    var destinationTrip : String? {
        didSet{
            if destinationTrip?.count == 0 {
                destinationTrip = nil
            }
            searchArea?.to?.text = destinationTrip
        }
    }
    
    
    var routes : [Route] = [
        Route("")
    ]
    
    var locations = ["Current", "Bern", "Zurich"]
    
    var searchArea : ToFromSearch?
    
    lazy var locationResult : UITableView = UITableView(frame: mapView.frame)
    lazy var routesResult : UITableView = UITableView(frame: mapView.frame)
    
    func addSearchArea(){
        if let xib = Bundle.main.loadNibNamed("ToFromSearch", owner: self, options: nil){
            searchArea = xib.first as? ToFromSearch
            if let area = searchArea{
                sizer.insertArrangedSubview(area, at: 0)
            }
        }
    }
    
    func setDelegates(){
        // MapView
        mapView.delegate = self
        // Search location table
        locationResult.delegate = self
        locationResult.dataSource = self
        // Search route table
        routesResult.delegate = self
        routesResult.dataSource = self
        // To Search field
        if let toTF = searchArea?.to {
            toTF.delegate = self
        }
        // From Search field
        if let fromTF = searchArea?.from {
            fromTF.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchArea()
        setDelegates()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resetTableFrame(_ tableView : UITableView){
        if tableView.tag == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                tableView.frame.size.height = 0.0
            }, completion: { finished in
                tableView.frame = .zero
            })
            
        }else{
            tableView.frame = mapView.bounds
        }
        tableView.reloadData()
    }
    
    func toogleTableResults(_ tableView : UITableView){
        tableView.tag = abs(tableView.tag - 1)
        resetTableFrame(tableView)
        if tableView.superview != mapView{
            mapView.addSubview(tableView)
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}

extension MainMapViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        inScopeTextField = textField
        
        if textField == searchArea?.to {
            // Do places call, on callback : toogleTableResults(locationResult)
            print("HERE")
            toogleTableResults(locationResult)
            
        }
        
        if textField == searchArea?.from {
            // Do places call, on callback : toogleTableResults(locationResult)
            print("THERE")
            toogleTableResults(locationResult)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension MainMapViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == locationResult {
            return locations.count
        } else if tableView == routesResult{
            return routes.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == locationResult {
            let cell  = UITableViewCell(style: .default, reuseIdentifier: "location")
            cell.textLabel?.text = locations[indexPath.row]
            return cell
        }else if tableView == routesResult {
            if let xib = Bundle.main.loadNibNamed("RouteCell", owner: self, options: nil){
                if let cell  = xib.first as? RouteTableViewCell{
                    cell.route = routes.first
                    return cell
                }
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "other")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == locationResult {
            
            // Get the to the model
            if inScopeTextField == searchArea?.to{
                destinationTrip = locations[indexPath.row]
            }
            if inScopeTextField == searchArea?.from{
                originTrip = locations[indexPath.row]
            }
            
            // Show the other TF if hidden
            if inScopeTextField == searchArea?.to {
                searchArea?.showFromPanel()
            }
            
            
            // Do the call if possible
            if let to = destinationTrip,
                let from = originTrip
                {
                // Execute final call
                print("Call the locations API with from \(from) and to \(to)")
                toogleTableResults(routesResult)
            }else{// Switch TF otherwise
                if searchArea?.from?.isFirstResponder ?? false {
                    searchArea?.to?.becomeFirstResponder()
                }else {
                    searchArea?.from?.becomeFirstResponder()
                }
            }

        } else if tableView == routesResult {
            // PAINT EVERYTHING
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        toogleTableResults(tableView)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

