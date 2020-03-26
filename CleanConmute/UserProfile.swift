//
//  SecondViewController.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/27/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {

    
    @IBOutlet weak var icon1 : UIImageView!
    @IBOutlet weak var icon2 : UIImageView!
    @IBOutlet weak var icon3 : UIImageView!
    @IBOutlet weak var icon4 : UIImageView!
    @IBOutlet weak var icon5 : UIImageView!
    
    @IBOutlet weak var slider1 : UISlider!
    @IBOutlet weak var slider2 : UISlider!
    @IBOutlet weak var slider3 : UISlider!
    @IBOutlet weak var slider4 : UISlider!
    @IBOutlet weak var slider5 : UISlider!
    
    @IBOutlet weak var mattermostlabel: UILabel!
    @IBOutlet weak var cartypelabel: UILabel!
    
    @IBOutlet weak var carChoiceSelector : UISegmentedControl!

    enum CarChoice : String {
        case No
        case Petrol
        case Diesel
        case Electric
    }
    
    var cost_weight : Double {
        get {
            let defaults = UserDefaults.standard
//            return defaults.double(forKey: "cost_weight")
            var value = 0.6
            if defaults.double(forKey: "cost_weight") != 0 {
                value = defaults.double(forKey: "cost_weight")
            }
            return value
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "cost_weight")
            defaults.synchronize()
        }
    }
    
    var calories_weight : Double {
        get {
            let defaults = UserDefaults.standard
            var value = 0.6
            if defaults.double(forKey: "calories_weight") != 0 {
                value = defaults.double(forKey: "calories_weight")
            }
            return value
//            return defaults.double(forKey: "calories_weight")
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "calories_weight")
            defaults.synchronize()
        }
    }
    
    var emission_weight : Double {
        get {
            let defaults = UserDefaults.standard
//            return defaults.double(forKey: "emission_weight")
            var value = 0.6
            if defaults.double(forKey: "emission_weight") != 0 {
                value = defaults.double(forKey: "emission_weight")
            }
            return value
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "emission_weight")
            defaults.synchronize()
        }
    }
    
    var toxicity_weight : Double {
        get {
            let defaults = UserDefaults.standard
//            return defaults.double(forKey: "toxicity_weight")
            var value = 0.6
            if defaults.double(forKey: "toxicity_weight") != 0 {
                value = defaults.double(forKey: "toxicity_weight")
            }
            return value
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "toxicity_weight")
            defaults.synchronize()
        }
    }
    
    var time_weight : Double {
        get {
            let defaults = UserDefaults.standard
//            return defaults.double(forKey: "time_weight")
            var value = 0.6
            if defaults.double(forKey: "time_weight") != 0 {
                value = defaults.double(forKey: "time_weight")
            }
            return value
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "time_weight")
            defaults.synchronize()
        }
    }
    
    var car : CarChoice {
        get {
            return CarChoice(rawValue: carChoiceSelector.titleForSegment(at: carChoiceSelector.selectedSegmentIndex) ?? "No") ?? .No
        }
        set{
            var index = 0
            switch car {
            case .Petrol:
                index = 1
            case .Diesel:
                index = 2
            case .Electric:
                index = 3
            default:
                break
            }
            let defaults = UserDefaults.standard
            defaults.set(index, forKey: "car_choice")
            defaults.synchronize()
        }
    }
    
    
    func getUserPreferences(){
        let defaults = UserDefaults.standard
        print("__")
        print(defaults.double(forKey: "cost_weight"))
        print("__")
        cost_weight = defaults.double(forKey: "cost_weight")
        print("__")
        print(defaults.double(forKey: "cost_weight"))
        print("__")
        calories_weight = defaults.double(forKey: "calories_weight")
        emission_weight = defaults.double(forKey: "emission_weight")
        toxicity_weight = defaults.double(forKey: "toxicity_weight")
        time_weight = defaults.double(forKey: "time_weight")
        car = CarChoice(rawValue: defaults.string(forKey: "car_choice") ?? "No") ?? .No
    }
    
    func updateSliders(){
        print(cost_weight)
        print(calories_weight)
        print(emission_weight)
        print(toxicity_weight)
        print(time_weight)
        slider1.value = Float(cost_weight)
        slider2.value = Float(calories_weight)
        slider3.value = Float(emission_weight)
        slider4.value = Float(toxicity_weight)
        slider5.value = Float(time_weight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var themes = [(UIImageView?, UISlider?, UIColor)]()
        themes.append((icon1, slider1, UIColor.red))
        themes.append((icon2, slider2, UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)))
        themes.append((icon3, slider3, UIColor.blue))
        themes.append((icon4, slider4, UIColor.orange))
        themes.append((icon5, slider5, UIColor.purple))
        
        for theme in themes{
            if let theIcon = theme.0 {
                theIcon.image = theIcon.image?.withRenderingMode(.alwaysTemplate)
                theIcon.tintColor = theme.2
            }
            if let theSlider = theme.1 {
                theSlider.tintColor = theme.2
            }
        }
        
        getUserPreferences()
        updateSliders()
    }
    

    @IBAction func sliderChange(_ sender: UISlider) {
        switch sender {
        case slider1:
            cost_weight = Double(sender.value)
        case slider2:
            calories_weight = Double(sender.value)
        case slider3:
            emission_weight = Double(sender.value)
        case slider4:
            toxicity_weight = Double(sender.value)
        case slider5:
            time_weight = Double(sender.value)
        default:
            break
        }
    }
    
    @IBAction func car_type_changed(_ sender: UISegmentedControl) {
        car = CarChoice(rawValue: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "No") ?? .No
    }
    
    @IBAction func car_type(_ sender: UISegmentedControl) {
        print("Unused function - was wrong in code")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

