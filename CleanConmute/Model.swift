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

enum RouteType {
    case walking
    case biking
    case motorcycle
    case car
    case train
    case plane
    case ship
    case eScooter
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
    let carbonFootPrint : Double
    let toxicityFootPrint : Double
    let secondsRequired : UInt
    let caloriesBurnt : Int
    
    //Color
    let color : (Int, Int, Int)
    
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
    
    init(_ json : String) {
        // Start Begin
        fromAsText = "Zurich, HB"
        toAsText = "IBM ZRL"
        fromGpsLocation = GPSLocation(longitude: 20.0, latitude: 20.0, altitude: 0.0)
        toGpsLocation = GPSLocation(longitude: 20.1, latitude: 20.1, altitude: 0.0)
        
        // Type
        type = .walking
        
        // Info on route
        price = 20.0
        carbonFootPrint = 0.1
        toxicityFootPrint = 0.3
        secondsRequired = 1200
        caloriesBurnt = 300
        
        //Color
        color = (200, 100, 50)
        
        // Poliline
        route = []
    }
}
