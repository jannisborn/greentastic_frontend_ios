//
//  StatisticsViewController.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/28/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    // var label_list = [UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50)),
    var label_list: [UILabel] = []
    var saved_label_list: [UILabel] = []
    var smileys: [UIImageView] = []
    
    let categories = ["dollar", "flame", "co2", "toxic"]
    let einheiten = ["$", "kcal", "kg", "g"]
    //smiley1 is happy, smiley5 is unhappy
    let smileyoptions = ["smiley_1", "smiley_2", "smiley_3", "smiley_4", "smiley_5"]
    
    let green = [0.4, 0.8, 0.2]
    let red = [0.86, 0.08, 0.24]
    let yellow = [0.78, 0.78, 0.2]
    let greenYellow = [0.38, -0.02, 0] // yellow - green
    let yellowRed = [0.08, -0.7, 0.04] // red - yellow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // get screen width
        let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
        
        // title of screen
        let title_label = UILabel(frame: CGRect(x: 0, y: 10, width: screenWidth, height: 21))
        title_label.center = CGPoint(x: screenWidth/2, y: 80)
        title_label.textAlignment = .center
        title_label.font = UIFont.boldSystemFont(ofSize: 24.0)
        title_label.text = "Your score balance"
        self.view.addSubview(title_label)
        
        // explanation label:
        let explanation_label = UILabel(frame: CGRect(x: 0, y: 30, width: screenWidth-100, height: 221))
        explanation_label.center = CGPoint(x: screenWidth/2, y: 140)
        explanation_label.textAlignment = .center
        explanation_label.font = UIFont(name:"HelveticaNeue", size: 13.0)
        explanation_label.text = "Each time you select a transport option by selecting a row in the transport overview, the values here are updated."
        explanation_label.contentMode = .scaleToFill
        explanation_label.numberOfLines = 0
        self.view.addSubview(explanation_label)
        
        //start y
        var posY = 170
        // header for table  label:
        let header = UILabel(frame: CGRect(x:0, y:posY+40, width:Int(screenWidth), height:30))
        header.center = CGPoint(x: Int(screenWidth/2), y: posY+40)
        header.textAlignment = .center
        header.font = UIFont.boldSystemFont(ofSize: 15.0)
        header.text = "Achieved (% of best/worst case)"
        self.view.addSubview(header)

        
        for i in 0...3{
            let cat = categories[i]
            // add image in the beginning
            posY = posY + 60
            let image = UIImage(named: cat)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x:20, y:posY, width:50, height:50)
            self.view.addSubview(imageView)
            
            // add absolute label
            let val_label = UILabel(frame: CGRect(x:Int(2*screenWidth/5), y:posY+23, width:150, height:30))
            val_label.center = CGPoint(x: Int(2*screenWidth/5), y: posY+23)
            val_label.textAlignment = .center
            val_label.font =  UIFont.boldSystemFont(ofSize: 15.0)
            // get emission value
            val_label.text = "0.0 "+einheiten[i]
            label_list.append(val_label)
            self.view.addSubview(val_label)
            
            // add relative label
            let rel_label = UILabel(frame: CGRect(x:Int(3*screenWidth/5), y:posY+23, width:150, height:30))
            rel_label.center = CGPoint(x: Int(3*screenWidth/5), y: posY+23)
            rel_label.textAlignment = .center
            rel_label.font =  UIFont.boldSystemFont(ofSize: 15.0) // UIFont(name:"HelveticaNeue", size: 15)
            // get emission value
            rel_label.text = "0.0 " //+einheiten[i]
            saved_label_list.append(rel_label)
            self.view.addSubview(rel_label)
            
            // add smiley
            let smileyimg = UIImage(named: smileyoptions[2])
            let smiley = UIImageView(image: smileyimg!)
            smiley.frame = CGRect(x:Int(4*screenWidth/5), y:posY+5, width:40, height:40)
            view.addSubview(smiley)
            smileys.append(smiley)
            }
        
        // reset button
        let resetButton = UIButton(frame: CGRect(x: Int(screenWidth/2)-30, y: posY+60, width: 100, height: 30))
        resetButton.setTitle("reset", for: .normal)
        resetButton.titleLabel?.text = "reset all"
        resetButton.addTarget(self, action: #selector(resetToZero), for: .touchUpInside)
        resetButton.backgroundColor = .red
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.layer.cornerRadius = 10
        self.view.addSubview(resetButton)
        
        }
    
    @objc func resetToZero(sender: UIButton!) {
        let defaults = UserDefaults.standard
        for i in 0...3 {
            defaults.set(0, forKey: categories[i]+"_val")
            defaults.set(0, forKey: categories[i]+"_valworst")
            label_list[i].text = "0.0 "+einheiten[i]
            saved_label_list[i].text = "0.0 %" // +einheiten[i]
            
            // reset text colour to black
            let colorUI = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: 1.0)
            saved_label_list[i].textColor = colorUI
            label_list[i].textColor = colorUI
            
            // reset smileys
            smileys[i].image = UIImage(named: smileyoptions[2])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // update labels
        let defaults = UserDefaults.standard
        for i in 0...3 {
            let emis_val = defaults.double(forKey: categories[i]+"_val")
            let rounded_emis_val = round(emis_val*10)/10
            label_list[i].text = "\(rounded_emis_val) "+einheiten[i]
            let worst_val = defaults.double(forKey: categories[i]+"_valworst")
            
            var percent_val = 0
            if worst_val != 0{
                percent_val = Int(round((emis_val/worst_val)*100))
                
                // set text colour
                var score = emis_val/worst_val
                if i==1{
                    score = 1-score // convert for calories
                }
                let textcol = getColour(score: score)
                let colorUI = UIColor(red: CGFloat(textcol[0]), green: CGFloat(textcol[1]), blue: CGFloat(textcol[2]), alpha: 1.0)
                saved_label_list[i].textColor = colorUI
                label_list[i].textColor = colorUI
                
                // set corresponding smiley
                let roundedscore = round(score*4)
                let smileyimg = UIImage(named: smileyoptions[Int(roundedscore)])
                smileys[i].image = smileyimg?.withRenderingMode(.alwaysTemplate)
                smileys[i].tintColor = colorUI //TODO
            }
            
            // set text of percent labels
            saved_label_list[i].text = "\(percent_val) %" //+einheiten[i]
            
        }
    }
    
    func getColour(score: Double) -> Array<Double> {
        if score < 0.5 {
            let scale = (score/0.5)
            let greenYellowScale = [scale*greenYellow[0], scale*greenYellow[1], scale*greenYellow[2]]
            let col = zip(green, greenYellowScale).map(+)
            return col
        }else{
            let scale = ((score-0.5)/0.5)
            let yellowRedScale = [scale*yellowRed[0], scale*yellowRed[1], scale*yellowRed[2]]
            let col = zip(yellow, yellowRedScale).map(+)
            return col
        }
    }
}
