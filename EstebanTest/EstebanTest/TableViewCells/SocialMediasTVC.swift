//
//  SocialMediasTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

class SocialMediasTVC: NibCell {
    
    @IBOutlet weak var containerView: UIStackView?
   
    override var content: Any? {
        didSet {
            guard let content = content as? SocialMedia else {
                return
            }
            
            if let channels = content.youtubeChannel {
                let buttonImage = UIImage(named: "youTubeImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                for (idx, _) in channels.enumerated() {
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    button.backgroundColor = .white
                    button.setImage(buttonImage, for: .normal)
                    button.tintColor = Constants.mainPalletTextColor
                    button.addTarget(self, action: #selector(youTubeAction), for: .touchUpInside)
                    button.tag = 100 + idx
                    
                    containerView?.addArrangedSubview(button)
                }
            }

            if let channels = content.facebook {
                let buttonImage = UIImage(named: "facebookImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                for (idx, _) in channels.enumerated() {
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    button.backgroundColor = .white
                    button.setImage(buttonImage, for: .normal)
                    button.tintColor = Constants.mainPalletTextColor
                    button.addTarget(self, action: #selector(facebookAction), for: .touchUpInside)
                    button.tag = 200 + idx
                    
                    containerView?.addArrangedSubview(button)
                }
            }
            
            if let channels = content.twitter {
                let buttonImage = UIImage(named: "twitterImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                for (idx, _) in channels.enumerated() {
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    button.backgroundColor = .white
                    button.setImage(buttonImage, for: .normal)
                    button.tintColor = Constants.mainPalletTextColor
                    button.addTarget(self, action: #selector(twitterAction), for: .touchUpInside)
                    button.tag = 300 + idx
                    
                    containerView?.addArrangedSubview(button)
                }
            }
        }
    }
    
    func youTubeAction(sender:UIButton!) {
        guard let content = content as? SocialMedia else {
            return
        }
        
        print("Should open YouTube to: \(content.youtubeChannel![sender.tag - 100])")
    }
    
    func facebookAction(sender:UIButton!) {
        guard let content = content as? SocialMedia else {
            return
        }
        
        print("Should open Facebook to: \(content.facebook![sender.tag - 200])")
    }
    
    func twitterAction(sender:UIButton!) {
        guard let content = content as? SocialMedia else {
            return
        }
        
        print("Should open Twitter to: \(content.twitter![sender.tag - 300])")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .socialMedias
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        containerView?.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

