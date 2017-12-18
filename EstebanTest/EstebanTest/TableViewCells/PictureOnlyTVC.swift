//
//  PictureOnlyTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

protocol PictureOnlyTVCDelegate : class {
    func pictureCellFinishedLoadingRemoteImage(size: CGSize, cell:UITableViewCell)
}

class PictureOnlyTVC: NibCell {
    //In memory cache: Temporary solution.
    static var imageCache : [String:UIImage] = [:]
    
    @IBOutlet weak var pictureImageView: UIImageView?
    weak var delegate: PictureOnlyTVCDelegate?
    
    override var content: Any? {
        didSet {
            guard let content = content as? String else {
                return
            }
            
            if let image = PictureOnlyTVC.imageCache[content] {
                self.pictureImageView?.image = image
                self.pictureImageView?.sizeToFit()
                self.delegate?.pictureCellFinishedLoadingRemoteImage(size: image.size, cell: self)
            } else {
                pictureImageView?.downloadedFrom(link: content) { size in
                    if let image = self.pictureImageView?.image {
                        self.pictureImageView?.sizeToFit()
                        PictureOnlyTVC.imageCache[content] = image
                        self.delegate?.pictureCellFinishedLoadingRemoteImage(size: size, cell: self)
                    }
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        cellType = .pictureOnly
        pictureImageView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        pictureImageView?.image = nil
        delegate = nil
    }
    
}
