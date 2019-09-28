//
//  SecondViewController.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/27/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {


    var cost_weight: Double = 0.6
    var calories_weight: Double = 0.6
    var emission_weight: Double = 0.6
    var toxicity_weight: Double = 0.6
    var time_weight: Double = 0.6
    var car: String = "Petrol"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func cost_change(_ sender: UISlider) {
        cost_weight = Double(sender.value)
    }
    
    @IBAction func calories_change(_ sender: UISlider) {
        calories_weight = Double(sender.value)
    }
    
    @IBAction func emission_change(_ sender: UISlider) {
        emission_weight = Double(sender.value)
    }
    
    @IBAction func toxicity_change(_ sender: UISlider) {
        toxicity_weight = Double(sender.value)
    }
    
    @IBAction func time_change(_ sender: UISlider) {
        time_weight = Double(sender.value)
    }
    
    @IBAction func car_type(_ sender: UISegmentedControl) {
        car = sender.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideFromPanel(){
        
    }

}

