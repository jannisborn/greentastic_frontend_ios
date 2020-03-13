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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth-30, height: 400))
//        label.center = CGPoint(x: screenWidth/2, y: screenHeight * (1/14 + 35000/(screenWidth*screenHeight)))
        let label_center = screenHeight * (1/14) + screenHeight * (65/screenWidth)
        // This is to get the size of the UIlabel dynamically
        label.center = CGPoint(x: screenWidth/2, y: .greatestFiniteMagnitude)
        label.textAlignment = .justified
        label.font = UIFont(name:"HelveticaNeue", size: 13.0)
        label.text = "Greentastic helps you to find the best type of transport for your commute! \nIt compares by 5 criteria: Cost, CO2-emissions, duration, nitric oxide emissions and the calories you burn. \nType in a destination and get an overview of respective scores, as well as the routes. \n\nDISCLAIMER: We do not claim correctness of any of the provided information. Prices are estimations, and emissions are researched to the best of our knowledge, but different sources claim different values. \n\nFor transparancy, we provide all our sources below. Tap the transport symbol for each category to open the source links in your browser. We use the GoogleMaps API to compute directions."
//        label.sizeToFit()
        let text_center_height = label.frame.height/3 + screenHeight * (1/14)
        label.center = CGPoint(x: screenWidth/2, y: text_center_height)
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
        let icons_height = label.frame.height*(1/3) + screenHeight * (1/14)
        let widthforone = (screenWidth-2*buttonX)/5
        for villain in categories {
            let villainButton = UIButton(frame: CGRect(x: buttonX, y: icons_height + 0.2*screenHeight, width: 50, height: 50))
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
        imageView.frame = CGRect(x:screenWidth*1/6, y:github_button_height-(screenWidth/2), width:screenWidth/3, height:screenWidth/3)
        self.view.addSubview(imageView)
        
//        Patreon donate button
        let patreonButton = UIButton(frame: CGRect(x: screenWidth*2/3, y: github_button_height-(screenWidth/2), width: screenWidth/3, height: screenWidth/3))
        let image = UIImage(named: "patreon")
        patreonButton.setImage(image, for: .normal)
        patreonButton.contentVerticalAlignment = .fill
        patreonButton.contentHorizontalAlignment = .fill
        
        buttonX = buttonX + widthforone  // we are going to space these UIButtons 50px apart
        
        patreonButton.titleLabel?.text = "Patreon"
        patreonButton.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
        self.view.addSubview(patreonButton)
        
        // Patreon text
        let patreonText = UIButton(frame: CGRect(x: screenWidth*3/4 , y: github_button_height-(screenWidth*0.2), width: 100, height: 30))
        patreonText.contentVerticalAlignment = .fill
        patreonText.contentHorizontalAlignment = .fill
        patreonText.titleLabel?.font = UIFont(name: "Helvetica", size: 22);
        patreonText.titleLabel?.text = "Patreon"
        patreonText.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
        patreonText.setTitleColor(.black, for: .normal)
        patreonText.setTitle("Donate!", for: .normal)
        self.view.addSubview(patreonText)
        
        
//        Github button
        let github_button = UIButton(frame: CGRect(x: screenWidth*(8/9), y: github_button_height, width: 30, height: 30))
        let github_icon = UIImage(named: "github")
        
        github_button.setImage(github_icon, for: .normal)
        github_button.titleLabel?.text = "GitHub"
        github_button.addTarget(self, action: #selector(goToLinks), for: .touchUpInside)
        self.view.addSubview(github_button)  // myView in this case is the view you want these buttons added
        
        
        // license text
        let license_text = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 221))
        license_text.center = CGPoint(x: 10+screenWidth/2, y: screenHeight * (8/9)-10)
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
        case "Patreon":
            goPatreonLink()
        case "Donate!":
            goPatreonLink()
        default:
            goGitHubLink()
            
        }
    }
    @objc func goPatreonLink() {
        if let url = URL(string: "https://www.patreon.com/user?u=31534628&fan_landing=true"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goCaloriesLink() {
        if let url = URL(string: "https://www.foodspring.ch/kalorienverbrauch-tabelle"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goCarbonLink() {
        if let url = URL(string: "https://github.com/jannisborn/greentastic/blob/master/SOURCES.md/#environment"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goToxicityLink() {
        if let url = URL(string: "https://github.com/jannisborn/greentastic/blob/master/SOURCES.md/#environment"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goDurationLink() {
        if let url = URL(string: "https://www.google.com/maps"){
            UIApplication.shared.open(url)
        }
    }
    @objc func goPriceLink() {
        if let url = URL(string: "https://github.com/jannisborn/greentastic/blob/master/SOURCES.md/#prices"){
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
