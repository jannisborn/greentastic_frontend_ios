//
//  InfoViewController.swift
//  CleanConmute
//
//  Created by Nina Wiedemann on 11.02.20.
//  Copyright © 2020 CatApps. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get screen width
        let screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width
        print(screenWidth)
        //title label
        let title_label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        title_label.center = CGPoint(x: screenWidth/2, y: 100)
        title_label.textAlignment = .center
        title_label.font = UIFont.boldSystemFont(ofSize: 24.0)
        title_label.text = "Info"
        self.view.addSubview(title_label)
        
        // text label
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: screenWidth-100, height: 221))
        label.center = CGPoint(x: screenWidth/2, y: 250)
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue", size: 13.0)
        label.text = "Greentastic is an information app for comparing transport with respect to five  criteria: Price, calories burnt,  CO2-emissions, toxicity (nitric oxide emissions) and duration. Type in a destination and get an overview of respective scores, as well as the routes. \n \n \n We do not claim correctness of any of the provided information. Prices are estimations, and emissions are researched to the best of our knowledge, but different sources claim different values. For transparancy, we provide all our sources below. Tap the transport symbol for each category to open the source links in your browser."
        // label.sizeToFit()
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        //Source label
        let source_label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 21))
        source_label.center = CGPoint(x: screenWidth/2, y: 450)
        source_label.textAlignment = .center
        source_label.font = UIFont.boldSystemFont(ofSize: 24.0)
        source_label.text = "Sources"
        self.view.addSubview(source_label)
        
        let categories = ["dollar", "flame", "co2", "toxic", "timer"]
        
        // let arrayOfVillains = ["s", "b", "s", "b"]
                
        var buttonX: CGFloat = 50  // our Starting Offset, could be 0
        let widthforone = (screenWidth-2*buttonX)/5
        for villain in categories {
            let villainButton = UIButton(frame: CGRect(x: buttonX, y: 500, width: 50, height: 50))
            buttonX = buttonX + widthforone  // we are going to space these UIButtons 50px apart
            // villainButton.layer.cornerRadius = 10  // get some fancy pantsy rounding
            villainButton.setTitle(villain, for: .normal)
            let image = UIImage(named: villain)
            villainButton.setImage(image, for: .normal)
            villainButton.titleLabel?.text = "\(villain)"
            villainButton.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
            self.view.addSubview(villainButton)  // myView in this case is the view you want these buttons added
            }
    }
    
    @objc func goToLinks(sender: UIButton!) {
        if sender.titleLabel?.text == "flame" {
            goCaloriesLink()
        }
    }
    
    @objc func goCaloriesLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.openURL(url)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
