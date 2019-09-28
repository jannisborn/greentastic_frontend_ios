//
//  SearchBarView.swift
//  CleanConmute
//
//  Created by Raul Catena on 9/28/19.
//  Copyright © 2019 CatApps. All rights reserved.
//

import UIKit

@IBDesignable
class ToFromSearch: UIView {
    
    @IBOutlet weak var from : UITextField?
    @IBOutlet weak var to : UITextField?
    @IBOutlet weak var fromPanel : UIStackView?
    @IBOutlet weak var toIcon : UIImageView?
    @IBOutlet weak var fromIcon : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        hideFromPanel()
        fromIcon?.image = fromIcon?.image?.withRenderingMode(.alwaysTemplate)
        toIcon?.image = toIcon?.image?.withRenderingMode(.alwaysTemplate)
        fromIcon?.tintColor = UIColor.init(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        toIcon?.tintColor = UIColor.init(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    }
    
    func resize(){
        
    }
    
    func hideFromPanel(){
        fromPanel?.isHidden = true
    }
    func showFromPanel(){
        fromPanel?.isHidden = false
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
