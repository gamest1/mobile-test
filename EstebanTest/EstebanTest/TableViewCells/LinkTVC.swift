//
//  LinkTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

protocol LinkTVCDelegate : class {
    func cellWantsToOpenBrowser(url: String?)
}

class LinkTVC: NibCell {
    
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var linkLabel: UILabel?
    @IBOutlet weak var goButton: UIButton?
    weak var delegate: LinkTVCDelegate?
    
    override var content: Any? {
        didSet {
            guard let content = content as? ContactTypeItem else {
                return
            }
            linkLabel?.text = content.string
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .link
        
        mainTitle?.textColor = Constants.mainPalletColor
        mainTitle?.font = Constants.titleFont
        mainTitle?.text = "Website"
        
        linkLabel?.textColor = Constants.mainPalletTextColor
        linkLabel?.font = Constants.smallTitleFont
        
        let buttonImage = UIImage(named: "goImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        goButton?.setImage(buttonImage, for: .normal)
        goButton?.tintColor = Constants.mainPalletColor
        goButton?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
    }
    
    @IBAction func openLink(sender:UIButton!) {
        self.delegate?.cellWantsToOpenBrowser(url: linkLabel?.text)
// Opens Safari app
//        if let url = linkLabel?.text {
//            UIApplication.shared.open(NSURL(string: url)! as URL,
//                                  options: [:],
//                        completionHandler: nil)
//        }
    }
}

