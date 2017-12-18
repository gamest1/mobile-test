//
//  ResourceSection.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-16.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import UIKit


public enum ResourceSectionType: String {
    case photo = "Photo"
    case description = "Description"
    case contact = "Contact Information"
    case address = "Addresses"
    case social = "Social Media"
    case notes = "Notes"
}

public class ResourceSection : DetailCellRepresentation {
    public var title : String
    public var numberOfRows : Int
    public var sectionType : ResourceSectionType
    
    public init?(title: String, rows: Int, type: ResourceSectionType) {
        self.title = title
        self.numberOfRows = rows
        self.sectionType = type
    }

// MARK: DetailCellRepresentation protocol:
    
    func tableView(_ tableView: UITableView, representationForRowAtIndexPath indexPath: IndexPath, resource: Resource) -> UITableViewCell? {
        switch sectionType {
        case .photo:
            return tableView.dequeueReusableCell(withIdentifier: PictureOnlyTVC.identifier, for: indexPath) as? PictureOnlyTVC
        case .description:
            return tableView.dequeueReusableCell(withIdentifier: TextOnlyTVC.identifier, for: indexPath) as? TextOnlyTVC
        case .address:
            return tableView.dequeueReusableCell(withIdentifier: AddressTVC.identifier, for: indexPath) as? AddressTVC
        case .contact:
            //The contact section happens to have three different types of cells. Consider refactoring.
            if let c:ContactTypeItem = resource.contactInfo?.contactTypeItemForRow(idx: indexPath.row) {
                if c.type == .website {
                    return tableView.dequeueReusableCell(withIdentifier: LinkTVC.identifier, for: indexPath) as? LinkTVC
                } else if c.type == .email {
                    return tableView.dequeueReusableCell(withIdentifier: EmailTVC.identifier, for: indexPath) as? EmailTVC
                } else {
                   return tableView.dequeueReusableCell(withIdentifier: PhoneNumberTVC.identifier, for: indexPath) as? PhoneNumberTVC
                }
            }
            return nil
        case .social:
            return tableView.dequeueReusableCell(withIdentifier: SocialMediasTVC.identifier, for: indexPath) as? SocialMediasTVC
        case .notes:
            return tableView.dequeueReusableCell(withIdentifier: TextOnlyTVC.identifier, for: indexPath) as? TextOnlyTVC
        default:
            return nil
        }
    }
}
