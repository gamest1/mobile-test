//
//  PhoneNumberTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

protocol PhoneNumberTVCDelegate : class {
    func cellWantsToCallPhone(number: String?)
    func cellWantsToSendSMSTo(number: String?)
}

class PhoneNumberTVC: NibCell {
    
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var phoneLabel: UILabel?
    @IBOutlet weak var callButton: UIButton?
    @IBOutlet weak var messageButton: UIButton?
    weak var delegate: PhoneNumberTVCDelegate?
    
    override var content: Any? {
        didSet {
            guard let content = content as? ContactTypeItem else {
                return
            }
            phoneLabel?.text = content.string
            mainTitle?.text = content.type.rawValue.capitalized
            
            if content.type == .fax {
                callButton?.isHidden = true
                messageButton?.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .phoneNumber
        
        mainTitle?.textColor = Constants.mainPalletColor
        mainTitle?.font = Constants.titleFont
        
        phoneLabel?.textColor = Constants.mainPalletTextColor
        phoneLabel?.font = Constants.smallTitleFont
        
        var buttonImage = UIImage(named: "phoneImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        callButton?.setImage(buttonImage, for: .normal)
        callButton?.tintColor = Constants.mainPalletColor
        callButton?.translatesAutoresizingMaskIntoConstraints = false
        
        buttonImage = UIImage(named: "textImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        messageButton?.setImage(buttonImage, for: .normal)
        messageButton?.tintColor = Constants.mainPalletColor
        messageButton?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
    }
    
    @IBAction func callNumber(sender:UIButton!) {
        self.delegate?.cellWantsToCallPhone(number: phoneLabel?.text)
    }
    @IBAction func sendText(sender:UIButton!) {
        self.delegate?.cellWantsToSendSMSTo(number: phoneLabel?.text)
    }
}

