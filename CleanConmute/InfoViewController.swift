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

        // Do any additional setup after loading the view.
        let caloriesLink = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 50))
        caloriesLink.setTitle("Calories",for: .normal)
        caloriesLink.addTarget(self, action: #selector(goCaloriesLink), for: .touchUpInside)
        caloriesLink.backgroundColor = .green
        self.view.addSubview(caloriesLink)
    }
     
    @objc func goCaloriesLink(sender: UIButton!) {
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
