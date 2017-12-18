//
//  BusinessHoursTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

class BusinessHoursTVC: NibCell {
    
    @IBOutlet weak var leftLabel: UILabel?
    @IBOutlet weak var rightLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .businessHours
        
        leftLabel?.textColor = Constants.mainPalletTextColor
        leftLabel?.font = Constants.titleFont

        rightLabel?.textColor = Constants.mainPalletSubTextColor
        rightLabel?.font = Constants.smallTitleFont
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        leftLabel?.text = nil
        rightLabel?.text = nil
    }
}


