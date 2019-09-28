//
//  TableViewCells.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/28/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

class RouteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var routeTypeIcon : UIImageView!
    
    @IBOutlet weak var costIcon : UIImageView!
    @IBOutlet weak var carbonFPIcon : UIImageView!
    @IBOutlet weak var caloriesIcon : UIImageView!
    @IBOutlet weak var toxicIcon : UIImageView!
    @IBOutlet weak var timeIcon : UIImageView!
    
    @IBOutlet weak var costLabel : UILabel!
    @IBOutlet weak var carbonFPLabel : UILabel!
    @IBOutlet weak var caloriesLabel : UILabel!
    @IBOutlet weak var toxicLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    
    var route : Route? {
        didSet {
            // Route type
            if let route_ = route {
                switch route_.type {
                case .biking:
                    routeTypeIcon.image = UIImage.init(named: "bicycle")?.withRenderingMode(.alwaysOriginal)
                case .walking:
                    routeTypeIcon.image = UIImage.init(named: "walking")?.withRenderingMode(.alwaysOriginal)
                case .car:
                    routeTypeIcon.image = UIImage.init(named: "car")?.withRenderingMode(.alwaysOriginal)
                case .eScooter:
                    routeTypeIcon.image = UIImage.init(named: "ebike")?.withRenderingMode(.alwaysOriginal)
                case .train:
                    routeTypeIcon.image = UIImage.init(named: "tram")?.withRenderingMode(.alwaysOriginal)
                case .motorcycle:
                    routeTypeIcon.image = UIImage.init(named: "vespa")?.withRenderingMode(.alwaysOriginal)
                case .plane:
                    routeTypeIcon.image = UIImage.init(named: "plane")?.withRenderingMode(.alwaysOriginal)
                    
                default:
                    routeTypeIcon.image = UIImage.init(named: "swimming")?.withRenderingMode(.alwaysOriginal)
                }
                costLabel.text = "\(route_.price) CHF"
                carbonFPLabel.text = "\(route_.carbonFootPrint)"
                caloriesLabel.text = "\(route_.caloriesBurnt) kCal"
                toxicLabel.text = "\(Int(route_.toxicityFootPrint))"
                timeLabel.text = "H"
            }
        }
    }
    
    override func awakeFromNib() {
        let imageViews = [costIcon, carbonFPIcon, caloriesIcon, toxicIcon, timeIcon]
        for iv in imageViews {
            iv?.image = iv?.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
