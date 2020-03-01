//
//  FirstViewController.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/27/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit
import MapKit

//let base_url = "http://localhost:5000"
let base_url = "https://clean-commuter.appspot.com"

class MainMapViewController: UIViewController {
    
//    struct SearchBar{
//        static let originX : CGFloat = 20.0
//        static let originY : CGFloat = 20.0
//        static var origin : CGPoint {
//            return CGPoint(x: originX, y: originY)
//        }
//    }
    var currMap = 1
    
    
    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var mapType : UISegmentedControl!
    
    @IBAction func switchMapOverview(_ sender: UISegmentedControl) {
    print("tags:", locationResult.tag, routesResult.tag)
        switch sender.selectedSegmentIndex {
        
        case 1:
            locationResult.tag = 1
            toogleTableResults(locationResult)
            routesResult.tag = 0
            toogleTableResults(routesResult)
            satelliteButton.removeFromSuperview()
        default:
            if routes.isEmpty{
                locationResult.tag = 1
                toogleTableResults(locationResult)
                routesResult.tag = 1
                toogleTableResults(routesResult)
            }else{
                paintRoutes(index: 0)
                routesResult.tag = 1
                toogleTableResults(routesResult)
            }
            view.addSubview(satelliteButton)
        }
    }
    
    
    var polyline : MKPolyline?
    var polylines = [(MKPolyline, (Double, Double, Double))]()
    var circles = [(MKCircle, (Double, Double, Double), RouteType)]()
    //var polylineView : MKPolylineView?
    
    @IBOutlet weak var sizer : UIStackView!
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
    
    let satelliteButton = UIButton(frame: CGRect(x: 10, y: 510, width: 50, height: 50))
    
    var routes = [Route]()
    var locations = [String]()
    var searchArea : ToFromSearch?
    
    let locationManager = CLLocationManager()
    
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
    
    func paintRoutes(index: Int){
        for (line, _) in polylines{
            mapView.removeOverlay(line)
        }
        polylines.removeAll()

        for (circ, _, _) in circles{
            mapView.removeOverlay(circ)
        }
        circles.removeAll()

        for route in routes {
            let coordinateArray = route.route.map{CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
            let polylin = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
            
            polylines.append((polylin, (0.5, 0.5, 0.5)))
            mapView.addOverlay(polylin)
            if coordinateArray.count > 0{
                let circ = MKCircle(center: coordinateArray[coordinateArray.count/2], radius: 20)
                circles.append((circ, route.color, route.type))
                mapView.addOverlay(circ)
            }
        }

        let route = routes[index]
        let coordinateArray = route.route.map{CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
        let polylin = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
        polylines.append((polylin, route.color))
        mapView.addOverlay(polylin)
        
        mapView.setVisibleMapRect(polylin.boundingMapRect, animated: true)
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
        spinner.tintColor = .blue
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "map_symbol_without_border")
        
        let heightTabBar = self.tabBarController!.tabBar.frame.height
        let heightMapTypeBar = self.mapType.frame.height
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        var bottomSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }
        // take height, subtract the weird iphone 11 bottom space, the tab bar, the segmentedControl, the height of the button and 30 extra for the apple maps icon
        let posButton = screenHeight - bottomSafeAreaHeight - heightTabBar - heightMapTypeBar - 80
        print(screenHeight, bottomSafeAreaHeight, heightTabBar, heightMapTypeBar)
        satelliteButton.frame = CGRect(x: 10, y: posButton, width: 50, height: 50)
        satelliteButton.setImage(image, for: .normal)
        satelliteButton.imageView?.contentMode = .scaleAspectFit
        
        satelliteButton.addTarget(self, action: #selector(changeMapType), for: .touchUpInside)
        

        self.view.addSubview(satelliteButton)
    }
    
    @objc func changeMapType(sender: UIButton!) {
         switch currMap{
             case 1:
                 mapView.mapType = .satellite
                 currMap = 2
             case 2:
                 mapView.mapType = .hybrid
                 currMap = 3
             default:
                 mapView.mapType = .standard
                 currMap = 1
         }
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
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func callAutoCompleteAPI(_ searchString : String) {
        startSpinner( inScopeTextField )
        let stringRequest = base_url + "/query_autocomplete?user_location=\(ownCoords)&search_string=\(searchString)"
        
        let url = URL(string: stringRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let task = URLSession.shared.dataTask(with: url) {[weak self](data, response, error) in
            guard let data = data else { return }
            
            self?.locations.removeAll()
            if self?.inScopeTextField == self?.searchArea?.from {
                self?.locations.append("Current Location")
            }
            let results = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            if let results_ = results as? Array<String> {
                for result in results_{
                    self?.locations.append(result)
                }
            }
            if let loc = self?.locationResult{
                DispatchQueue.main.async {
                    self?.routesResult.tag = 1
                    self?.toogleTableResults(self!.routesResult)
                    loc.tag = 0
                    self?.toogleTableResults(loc)
                    self?.satelliteButton.removeFromSuperview()
                    self?.stopSpinner()
                }
            }
        }
        task.resume()
    }
    
    var spinner = UIActivityIndicatorView(style: .gray)
    
    func startSpinner(_ iv : UIView?){
        if let i = iv {
            spinner.frame.origin = i.frame.origin
            spinner.frame.origin.x = i.bounds.width - 24
            spinner.frame.origin.y = 4
            i.addSubview(spinner)
        }
        spinner.startAnimating()
    }
    func stopSpinner(){
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    func callRoutesAPI(source : String, destination : String){
        
        var source_ : String = source
        
        // Sanitize if current location
        if source == "Current Location" {
            source_ = ownCoords
        }
        
        let defaults = UserDefaults.standard
        let cost = defaults.double(forKey: "cost_weight")
        let cals = defaults.double(forKey: "calories_weight")
        let emis = defaults.double(forKey: "emission_weight")
        let toxc = defaults.double(forKey: "toxicity_weight")
        let time = defaults.double(forKey: "time_weight")
        
        let car_type_index = defaults.integer(forKey: "car_choice")
        let car_choices = ["Petrol", "Petrol","Diesel", "Electric"]
        let car_type = car_choices[car_type_index]
        
        startSpinner( inScopeTextField )
        if let request = "/query_directions?source=\(source_)&destination=\(destination)&car_type=\( car_type)&weights=\(time),\(emis),\(cost),\(cals),\(toxc)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            let urlEncodedStringRequest = base_url + request
            
            if let url = URL(string: urlEncodedStringRequest){
                let task = URLSession.shared.dataTask(with: url) {[weak self](data, response, error) in
                    guard let data = data else { return }
                    
                    self?.routes.removeAll()
                    let results = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let results_ = results as? Dictionary<String, Any> {
                        
                        for (key, dict) in results_{
                            if let route_instance = Route(dict, type_string: key){
                                self?.routes.append(route_instance)
                            }
                            // Sort by total score
                            if let rts = self?.routes {
                                self?.routes = rts.sorted{
                                    return $0.totalScore > $1.totalScore
                                }
                            }
                        }
                    }
                    if let rout = self?.routesResult{
                        DispatchQueue.main.async {
                            self?.toogleTableResults(rout)
                        self?.satelliteButton.removeFromSuperview()
                            self?.mapType.selectedSegmentIndex = 1;
                            self?.stopSpinner()
                        }
                    }
                }
                task.resume()
            }
        }
    }
}

var ownCoords = "47.3769,8.5417"

extension MainMapViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        inScopeTextField = textField
        callAutoCompleteAPI(textField.text ?? "")
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
                    cell.route = routes[indexPath.row]
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
                callRoutesAPI(source: from, destination: to)
            }else{// Switch TF otherwise
                if searchArea?.from?.isFirstResponder ?? false {
                    searchArea?.to?.becomeFirstResponder()
                }else {
                    searchArea?.from?.becomeFirstResponder()
                }
            }

        } else if tableView == routesResult {
            self.mapType.selectedSegmentIndex = 0; //switch tab bar
            paintRoutes(index: indexPath.row)
            
            // update statistics values
            let defaults = UserDefaults.standard
            let selectedRoute = routes[indexPath.row]
            let route_properties = [selectedRoute.price, selectedRoute.caloriesBurnt, selectedRoute.carbonFootPrint, selectedRoute.toxicityFootPrint]
            let keys = ["dollar_val", "flame_val", "co2_val", "toxic_val"]
            let worst_cases = helper_compute_max()
            // save values
            for i in 0...3{
                let prev_val = defaults.double(forKey: keys[i])
                let worst_prev_val = defaults.double(forKey: keys[i]+"worst")
                defaults.set(worst_prev_val+worst_cases[i], forKey: keys[i]+"worst")
                defaults.set(prev_val + route_properties[i], forKey: keys[i])
            }
            defaults.synchronize()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        toogleTableResults(tableView)
        self.view.addSubview(satelliteButton)
    }
    
    func helper_compute_max() -> Array<Double> {
        var max_arr = [0.0, 0, 0, 0] // high value for calories is good
        for route in routes {
            let crits = [route.price, route.caloriesBurnt, route.carbonFootPrint, route.toxicityFootPrint]
            for i in 0...3{
                if crits[i] > max_arr[i] {
                    max_arr[i] = crits[i]
                }
            }
        }
        return max_arr
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}

extension MainMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            for (circ, color, _) in circles {
                if circ === overlay {
                    renderer.fillColor = UIColor.init(red: CGFloat(color.0), green: CGFloat(color.1), blue: CGFloat(color.2), alpha: 1.0)
                }
            }
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.init(white: 0.7, alpha: 0.5)
            for (poly, color) in polylines {
                if poly === overlay {
                    renderer.strokeColor = UIColor.init(red: CGFloat(color.0), green: CGFloat(color.1), blue: CGFloat(color.2), alpha: 1.0)
                }
            }
            if overlay === polyline { renderer.lineWidth = 16 }
            else { renderer.lineWidth = 6 }
            
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension MainMapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        ownCoords = "\(locValue.latitude),\(locValue.longitude)"
    }
}

