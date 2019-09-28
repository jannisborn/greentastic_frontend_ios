//
//  Model.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/28/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import Foundation

let secondsDay : UInt = 24 * 60 * 60
let secondsHour : UInt =  60 * 60
let secondsMinute : UInt =  60

enum RouteType : String {
    case walking
    case bicycling
    case ebike
    case ecar
    case escooter
    case hybridcar
    case driving
    case taxi
    case transit
}

struct GPSLocation {
    let longitude : Double
    let latitude : Double
    let altitude : Double
}

struct Route {
    // Start Begin
    let fromAsText : String
    let toAsText : String
    let fromGpsLocation : GPSLocation
    let toGpsLocation : GPSLocation

    // Type
    let type : RouteType
    
    // Info on route
    let price : Double
    let priceColor : (Double, Double, Double)
    let carbonFootPrint : Double
    let carbonFootPrintColor : (Double, Double, Double)
    let toxicityFootPrint : Double
    let toxicityFootPrintColor : (Double, Double, Double)
    let secondsRequired : UInt
    let secondsRequiredColor : (Double, Double, Double)
    let caloriesBurnt : Int
    let caloriesBurntColor : (Double, Double, Double)
    let distance : Double
    let distanceColor : (Double, Double, Double)
    
    //Color
    let color : (Double, Double, Double)
    
    // Poliline
    let route : [[(GPSLocation, GPSLocation)]]
    
    // Utility function
    func timeRequired()-> String {
        let days = secondsRequired / secondsDay
        var remainder = secondsRequired % secondsDay
        let hours = remainder / secondsHour
        remainder %= secondsHour
        let minutes = remainder / secondsMinute
        remainder %= secondsMinute
        return "\(days > 0 ? String(days) + "d" : "")\(hours > 0 ? String(hours) + "h" : "")\(days > 0 ? String(minutes) + "'" : "")"
    }
    
    init?(_ json : Any, type_string : String) {
        // Start Begin
        
        if let dict = json as? Dictionary<String, Any>{
            
//            print(type_string)
//            print("-----")
//            print(json)
            
            fromAsText = "Zurich, HB"
            toAsText = "IBM ZRL"
            fromGpsLocation = GPSLocation(longitude: 20.0, latitude: 20.0, altitude: 0.0)
            toGpsLocation = GPSLocation(longitude: 20.1, latitude: 20.1, altitude: 0.0)
            
            // Type
            type = RouteType(rawValue: type_string) ?? .walking
            
            // Info on route
            // Price
            price = Double((dict["price"] as? String) ?? "0") ?? 0
            if let color = dict["price_col"] as? Array<Double> {
                priceColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                priceColor = (0.5, 0.5, 0.5)
            }
            
            // Carbon footprint
            carbonFootPrint = Double((dict["emission"] as? String) ?? "0") ?? 0
            if let color = dict["emission_col"] as? Array<Double> {
                carbonFootPrintColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                carbonFootPrintColor = (0.5, 0.5, 0.5)
            }
            
            // Calories burnt
            caloriesBurnt = Int((dict["calories"] as? String) ?? "0") ?? 0
            if let color = dict["calories_col"] as? Array<Double> {
                caloriesBurntColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                caloriesBurntColor = (0.5, 0.5, 0.5)
            }
            
            // Duration
            let mins = UInt((dict["duration"] as? String) ?? "0") ?? 0
            secondsRequired = mins * 60
            if let color = dict["duration_col"] as? Array<Double> {
                secondsRequiredColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                secondsRequiredColor = (0.5, 0.5, 0.5)
            }
            
            //Toxicity
            toxicityFootPrint = 0.3
            toxicityFootPrintColor = (0.5, 0.5, 0.5)
    
            // Distance
            distance = Double((dict["distance"] as? String) ?? "0") ?? 0
            distanceColor = (0.5, 0.5, 0.5)
            
            //Color
            if let color_ = dict["total_weighted_score_col"] as? Array<Double> {
                color = (color_[0], color_[1], color_[2])
            }else{
                color = (0.5, 0.5, 0.5)
            }
            
            // Poliline
            route = []
        }else{
            return nil
        }
    }
}
