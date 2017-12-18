//
//  AddressTVC.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-19.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit
import MapKit

class AddressTVC: NibCell {
    
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var mapButton: UIButton?
   
    override var content: Any? {
        didSet {
            guard let content = content as? Address else {
                return
            }
            //Only display the map button if proper gps coordinates are available:
            if content.gps?.latitude == nil ||
                content.gps?.longitude == nil {
                mapButton?.isHidden = true
            }
            
            addressLabel?.text = String(format: "%@\n%@\n%@, %@ %@\n%@", content.label ?? "", content.address1 ?? "", content.city ?? "", content.state ?? "", content.zipCode ?? "", (content.country ?? "").capitalized)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellType = .address
        
        mainTitle?.textColor = Constants.mainPalletColor
        mainTitle?.font = Constants.titleFont
        mainTitle?.text = "Address"
        
        addressLabel?.textColor = Constants.mainPalletTextColor
        addressLabel?.font = Constants.smallTitleFont
        
        let buttonImage = UIImage(named: "mapImage", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        mapButton?.setImage(buttonImage, for: .normal)
        mapButton?.tintColor = Constants.mainPalletColor
    }
    
    
    @IBAction func openMap(sender:UIButton!) {
        guard let address = self.content as? Address,
              let lat = address.gps?.latitude,
              let long = address.gps?.longitude
            else {  print("Address item doesn't have proper GPS coordinates...")
                    return }
        
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = address.label
        mapItem.openInMaps(launchOptions: options)
    }
}

