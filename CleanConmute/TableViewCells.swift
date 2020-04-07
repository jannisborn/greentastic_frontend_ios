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
    
    func colorFromComponentsTuple(_ tuple : (Double, Double, Double)) -> UIColor{
        return UIColor(red: CGFloat(tuple.0), green: CGFloat(tuple.1), blue: CGFloat(tuple.2), alpha: CGFloat(1.0))
    }
    
    var route : Route? {
        didSet {
            // Route type
            if let route_ = route {
                
                switch route_.type {
                case .bicycling:
                    routeTypeIcon.image = UIImage.init(named: "bicycle")?.withRenderingMode(.alwaysTemplate)
                case .walking:
                    routeTypeIcon.image = UIImage.init(named: "walking")?.withRenderingMode(.alwaysTemplate)
                case .driving:
                    routeTypeIcon.image = UIImage.init(named: "car")?.withRenderingMode(.alwaysTemplate)
                case .escooter:
                    routeTypeIcon.image = UIImage.init(named: "stepper")?.withRenderingMode(.alwaysTemplate)
                case .transit:
                    routeTypeIcon.image = UIImage.init(named: "tram")?.withRenderingMode(.alwaysTemplate)
                case .ecar:
                    routeTypeIcon.image = UIImage.init(named: "vespa")?.withRenderingMode(.alwaysTemplate)
                case .taxi:
                    routeTypeIcon.image = UIImage.init(named: "taxi")?.withRenderingMode(.alwaysTemplate)
                case .ebike:
                    routeTypeIcon.image = UIImage.init(named: "ebike")?.withRenderingMode(.alwaysTemplate)
                default:
                    fatalError("Wrong route type")
                }
                
                costLabel.text = "\(route_.price)$"
                carbonFPLabel.text = "\(route_.carbonFootPrint)kg"
                caloriesLabel.text = "\(UInt(route_.caloriesBurnt))kcal"
                toxicLabel.text = "\(route_.toxicityFootPrint)g"
                timeLabel.text = route_.timeRequired()
                
                costIcon.tintColor = colorFromComponentsTuple(route_.priceColor)
                costLabel.textColor = colorFromComponentsTuple(route_.priceColor)
                carbonFPIcon.tintColor = colorFromComponentsTuple(route_.carbonFootPrintColor)
                carbonFPLabel.textColor = colorFromComponentsTuple(route_.carbonFootPrintColor)
                caloriesIcon.tintColor = colorFromComponentsTuple(route_.caloriesBurntColor)
                caloriesLabel.textColor = colorFromComponentsTuple(route_.caloriesBurntColor)
                toxicIcon.tintColor = colorFromComponentsTuple(route_.toxicityFootPrintColor)
                toxicLabel.textColor = colorFromComponentsTuple(route_.toxicityFootPrintColor)
                timeIcon.tintColor = colorFromComponentsTuple(route_.secondsRequiredColor)
                timeLabel.textColor = colorFromComponentsTuple(route_.secondsRequiredColor)
                
                routeTypeIcon.tintColor = colorFromComponentsTuple(route_.color)
            }
        }
    }
    
    override func awakeFromNib() {
        routeTypeIcon.image = routeTypeIcon.image?.withRenderingMode(.alwaysTemplate)
        routeTypeIcon.tintColor = UIColor.white
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
