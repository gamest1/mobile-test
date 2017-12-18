//
//  EmailTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

protocol EmailTVCDelegate : class {
    func cellWantsToSendEmail(to: String?)
}

class EmailTVC: NibCell {
    
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var emailLabel: UILabel?
    @IBOutlet weak var sendButton: UIButton?
    weak var delegate: EmailTVCDelegate?
  
    override var content: Any? {
        didSet {
            guard let content = content as? ContactTypeItem else {
                return
            }
            emailLabel?.text = content.string
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .email
        
        mainTitle?.textColor = Constants.mainPalletColor
        mainTitle?.font = Constants.titleFont
        mainTitle?.text = "Email Address"
        
        emailLabel?.textColor = Constants.mainPalletTextColor
        emailLabel?.font = Constants.smallTitleFont
        
        let buttonImage = UIImage(named: "sendImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        sendButton?.setImage(buttonImage, for: .normal)
        sendButton?.tintColor = Constants.mainPalletColor
        sendButton?.translatesAutoresizingMaskIntoConstraints = false
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
    }
    
    @IBAction func sendEmail(sender:UIButton!) {
        self.delegate?.cellWantsToSendEmail(to: emailLabel?.text)
    }
}


