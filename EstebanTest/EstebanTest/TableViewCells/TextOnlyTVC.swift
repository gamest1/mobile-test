//
//  TextOnlyTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

class TextOnlyTVC: NibCell {
    
    @IBOutlet weak var largeLabel: UILabel?
    
    override var content: Any? {
        didSet {
            guard let content = content as? String else {
                return
            }
            
            largeLabel?.text = content.removeSimpleHTMLTags()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .textOnly

        largeLabel?.backgroundColor = UIColor.white
        largeLabel?.textColor = UIColor.black
        largeLabel?.font = Constants.titleFont
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        largeLabel?.text = nil
    }
}

