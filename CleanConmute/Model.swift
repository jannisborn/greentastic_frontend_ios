//
//  Model.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/28/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import Foundation

let secondsDay : Double = 24 * 60 * 60
let secondsHour : Double =  60 * 60
let secondsMinute : Double =  60

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

let TransportTypeDict = [
    "walking": ["GM_Key": "w", "ImageName": "walking"],
    "bicycling": ["GM_Key": "b", "ImageName": "bicycle"],
    "ebike": ["GM_Key": "b", "ImageName": "ebike"],
    "escooter": ["GM_Key": "b", "ImageName": "stepper"],
    "driving": ["GM_Key": "d", "ImageName": "car"],
    "taxi": ["GM_Key": "d", "ImageName": "taxi"],
    "transit": ["GM_Key": "r", "ImageName": "tram"]
]

struct Route {
    // Start Begin
//    let fromAsText : String
//    let toAsText : String
//    let fromGpsLocation : GPSLocation
//    let toGpsLocation : GPSLocation

    // Type
    let type : RouteType
    
    // Info on route
    let price : Double
    let priceColor : (Double, Double, Double)
    let carbonFootPrint : Double
    let carbonFootPrintColor : (Double, Double, Double)
    let toxicityFootPrint : Double
    let toxicityFootPrintColor : (Double, Double, Double)
    let secondsRequired : Double
    let secondsRequiredColor : (Double, Double, Double)
    let caloriesBurnt : Double
    let caloriesBurntColor : (Double, Double, Double)
    let distance : Double
    let distanceColor : (Double, Double, Double)
    
    //Color and total score
    let totalScore : Double
    let color : (Double, Double, Double)
    
    // Poliline
    let route : [GPSLocation]
    
    // Utility function
    func timeRequired()-> String {
        let days = UInt(secondsRequired / secondsDay)
        var remainder = UInt(secondsRequired) % UInt(secondsDay)
        let hours = remainder / UInt(secondsHour)
        remainder %= UInt(secondsHour)
        let minutes = remainder / UInt(secondsMinute)
        remainder %= UInt(secondsMinute)
        
        var finalString = ""
        if days > 0 { finalString.append("\(days)d") }
        if hours > 0 { finalString.append("\(hours)h") }
        if minutes > 0 { finalString.append("\(minutes)'") }
        // if remainder > 0 { finalString.append("\(remainder)''") } // do not need seconds
        
        return finalString
    }
    
    init?(_ json : Any, type_string : String) {
        // Start Begin
        
        if let dict = json as? Dictionary<String, Any>{
            
//            fromAsText = "Zurich, HB"
//            toAsText = "IBM ZRL"
//            fromGpsLocation = GPSLocation(longitude: 20.0, latitude: 20.0, altitude: 0.0)
//            toGpsLocation = GPSLocation(longitude: 20.1, latitude: 20.1, altitude: 0.0)
            
            // Type
            type = RouteType(rawValue: type_string) ?? .walking
            
            // Info on route
            // Price
            price = (dict["price"] as? Double) ?? 0.0
            if let color = dict["price_col"] as? Array<Double> {
                priceColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                priceColor = (0.5, 0.5, 0.5)
            }
            
            // Carbon footprint
            carbonFootPrint = (dict["emission"] as? Double) ?? 0.0
            if let color = dict["emission_col"] as? Array<Double> {
                carbonFootPrintColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                carbonFootPrintColor = (0.5, 0.5, 0.5)
            }
            
            // Calories burnt
            caloriesBurnt = (dict["calories"] as? Double) ?? 0
            if let color = dict["calories_col"] as? Array<Double> {
                caloriesBurntColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                caloriesBurntColor = (0.5, 0.5, 0.5)
            }
            
            // Duration
            let seconds = (dict["duration"] as? Double) ?? 0
            secondsRequired = seconds
            if let color = dict["duration_col"] as? Array<Double> {
                secondsRequiredColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                secondsRequiredColor = (0.5, 0.5, 0.5)
            }
            
            //Toxicity
            toxicityFootPrint = (dict["toxicity"] as? Double) ?? 0
            if let color = dict["toxicity_col"] as? Array<Double> {
                toxicityFootPrintColor = (color[0]/255.0, color[1]/255.0, color[2]/255.0)
            }else{
                toxicityFootPrintColor = (0.5, 0.5, 0.5)
            }
    
            // Distance
            distance = (dict["distance"] as? Double) ?? 0
            distanceColor = (0.5, 0.5, 0.5)
            
            //Color and total score
            totalScore = (dict["total_weighted_score"] as? Double) ?? 0
            if let color_ = dict["total_weighted_score_col"] as? Array<Double> {
                color = (color_[0]/255.0, color_[1]/255.0, color_[2]/255.0)
            }else{
                color = (0.5, 0.5, 0.5)
            }
            
            // Polyline
            var route_container = [GPSLocation]()
            if let coords = dict["coordinates"] as? Array<Array<Double>>{
                for coord in coords{
                    route_container.append(GPSLocation(longitude: coord[1], latitude: coord[0], altitude: 0.0))
                }
            }
            route = route_container
        }else{
            return nil
        }
    }
}
