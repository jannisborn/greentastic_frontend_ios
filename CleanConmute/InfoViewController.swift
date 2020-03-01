//
//  InfoViewController.swift
//  CleanConmute
//
//  Created by Nina Wiedemann on 11.02.20.
//  Copyright © 2020 CatApps. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var scrollInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get screen width
        let screenWidth = UIScreen.main.fixedCoordinateSpace.bounds.width
        let screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height
        print(screenWidth)
        print(screenHeight)
        
        //title label
        let title_label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        title_label.center = CGPoint(x: screenWidth/2, y: screenHeight * (1/14))
        title_label.textAlignment = .center
        title_label.font = UIFont.boldSystemFont(ofSize: 24.0)
        title_label.text = "About Greentastic"
        self.view.addSubview(title_label)
        
        // text label
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: screenWidth-30, height: 221))
//        label.center = CGPoint(x: screenWidth/2, y: screenHeight * (1/14 + 35000/(screenWidth*screenHeight)))
        let label_center = screenHeight * (1/12) + 50000/screenWidth
        label.center = CGPoint(x: screenWidth/2, y: label_center)
        label.textAlignment = .justified
        label.font = UIFont(name:"HelveticaNeue", size: 13.0)
        label.text = "Greentastic helps you to find the best type of transport for your commute! \nIt compares by 5 criteria: Cost, CO2-emissions, duration, nitric oxide emissions and the calories you burn. \nType in a destination and get an overview of respective scores, as well as the routes. \n\nDISCLAIMER: We do not claim correctness of any of the provided information. Prices are estimations, and emissions are researched to the best of our knowledge, but different sources claim different values. For transparancy, we provide all our sources below. Tap the transport symbol for each category to open the source links in your browser."
//        label.sizeToFit()
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        self.view.addSubview(label)
        
//        //Source label
//        let source_label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 21))
//        source_label.center = CGPoint(x: screenWidth/2, y: screenHeight * (3/5))
//        source_label.textAlignment = .center
//        source_label.font = UIFont.boldSystemFont(ofSize: 24.0)
//        source_label.text = "Sources"
//        self.view.addSubview(source_label)
        
        let categories = ["dollar", "flame", "co2", "toxic", "timer"]
        
        // let arrayOfVillains = ["s", "b", "s", "b"]
                
        var buttonX: CGFloat = 20  // our Starting Offset, could be 0
        let widthforone = (screenWidth-2*buttonX)/5
        for villain in categories {
            let villainButton = UIButton(frame: CGRect(x: buttonX, y: label_center + 0.2*screenHeight, width: 50, height: 50))
            let image = UIImage(named: villain)
            villainButton.setImage(image, for: .normal)
            villainButton.contentVerticalAlignment = .fill
            villainButton.contentHorizontalAlignment = .fill
            
            buttonX = buttonX + widthforone  // we are going to space these UIButtons 50px apart
            // villainButton.layer.cornerRadius = 10  // get some fancy pantsy rounding
//            villainButton.setTitle(villain, for: .normal)
            
            villainButton.titleLabel?.text = "\(villain)"
            villainButton.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
            self.view.addSubview(villainButton)  // myView in this case is the view you want these buttons added
            }
        
        //license label
//        let license_label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 21))
//        license_label.center = CGPoint(x: screenWidth/2, y: screenHeight * (4/5))
//        license_label.textAlignment = .center
//        license_label.font = UIFont.boldSystemFont(ofSize: 24.0)
//        license_label.text = "License"
//        self.view.addSubview(license_label)
        

        
//        // contribute text
//        let contribute_text = UILabel(frame: CGRect(x: 0, y: 30, width: screenWidth-10, height: 221))
//        contribute_text.center = CGPoint(x: screenWidth/2, y: screenHeight * (4/5))
//        contribute_text.textAlignment = .left
//        contribute_text.font = UIFont(name:"HelveticaNeue", size: 13.0)
//        let contribute = "Contribute"
//        let attContribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize:13.0)]
//        let contributeStart = NSMutableAttributedString(string:contribute, attributes:attContribute)
//
//        contribute_text.text = "Contribute: "
//        // contribute_text.sizeToFit()
//        contribute_text.contentMode = .scaleToFill
//        contribute_text.numberOfLines = 0
//        self.view.addSubview(contribute_text)
        
        let github_button_height = screenHeight*(65/75)-10
        // AppIcon
        let icon = UIImage(named: "app_icon_large")
        let imageView = UIImageView(image: icon!)
//        imageView.contentMode = UIView.ContentMode.center
         // get some fancy pantsy rounding
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 25 //This will change with corners of image and height/2 will make this circle shape
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x:screenWidth/3, y:github_button_height-(screenWidth/3) - 15, width:screenWidth/3, height:screenWidth/3)
        self.view.addSubview(imageView)
        
        
        
        let github_button = UIButton(frame: CGRect(x: screenWidth*(8/9), y: github_button_height, width: 30, height: 30))
        let github_icon = UIImage(named: "github")
        
        github_button.setImage(github_icon, for: .normal)
        github_button.titleLabel?.text = "GitHub"
        github_button.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
        self.view.addSubview(github_button)  // myView in this case is the view you want these buttons added
        
        
        // license text
        let license_text = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth*0.8, height: 221))
        license_text.center = CGPoint(x: 10+0.8*screenWidth/2, y: screenHeight * (8/9)-10)
        license_text.textAlignment = .left
        license_text.font = UIFont(name:"HelveticaNeue", size: 13.0)
        let license = "License"
        let attLicense = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize:13.0)]
        let boldStart = NSMutableAttributedString(string:license, attributes:attLicense)
        let licenseRest = NSMutableAttributedString(string:": Greentastic V1.0. Copyright © 2020 \nJannis Born, Nina Wiedemann. All rights reserved.")
        let licenseTextParts = NSMutableAttributedString()
        licenseTextParts.append(boldStart)
        licenseTextParts.append(licenseRest)
        //        var att_lr = [NSAttributedString.Key.font : UIFont.labelFontSize(ofSize:13.0)]
        license_text.attributedText = licenseTextParts
        // license_text.sizeToFit()
        license_text.contentMode = .scaleToFill
        license_text.numberOfLines = 0
        self.view.addSubview(license_text)

    }
    
    @objc func goToLinks(sender: UIButton!) {
        switch sender.titleLabel?.text {
        case "dollar":
            goPriceLink()
        case "flame":
            goCaloriesLink()
        case "co2":
            goCarbonLink()
        case "toxic":
            goToxicityLink()
        case "timer":
            goDurationLink()
        case "GitHub":
            goGitHubLink()
        default:
            goGitHubLink()
            
        }
    }
    
    @objc func goCaloriesLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goCarbonLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goToxicityLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goDurationLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goPriceLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goGitHubLink() {
        if let url = URL(string: "https://www.github.com/jannisborn/greentastic"){
            UIApplication.shared.open(url)
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
