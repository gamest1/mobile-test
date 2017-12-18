//
//  NibCell.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-18.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit

enum ContactType : String {
    case website = "WEBSITE"
    case email = "EMAIL ADDRESS"
    case phone = "PHONE NUMBER"
    case fax = "FAX NUMBER"
    case tollfree = "TOLL FREE NUMBER"
}

public struct ContactTypeItem {
    var string: String
    var type : ContactType
}

//Since cell on each section have different looks, ResourceSection must conform to this protocol
protocol DetailCellRepresentation {
    func tableView(_ tableView: UITableView, representationForRowAtIndexPath indexPath: IndexPath, resource: Resource) -> UITableViewCell?
}

//Raw value is the reusableCellIndentifier
enum CellType : String {
    case pictureOnly = "PictureOnlyTVC"
    case textOnly = "TextOnlyTVC"
    case phoneNumber = "PhoneNumberTVC"
    case email = "EmailTVC"
    case link = "LinkTVC"
    case address = "AddressTVC"
    case socialMedias = "SocialMediasTVC"
    case businessHours = "BusinessHoursTVC"
}

public class NibCell: UITableViewCell {
    var content: Any?
    var cellType : CellType?
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
