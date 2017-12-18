//
//  ResourceSectionFactory.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-16.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import Foundation

public class ResourceSectionFactory {
    static func buildSection(type : ResourceSectionType, resource: Resource) -> ResourceSection? {
        switch type {
        case .photo:
            var cells:[PictureOnlyTVC] = []
            cells.append(PictureOnlyTVC(style: .default, reuseIdentifier: CellType.pictureOnly.rawValue))
            return ResourceSection(title: "How it looks?", rows: 1, type: .photo)
        case .description:
            var cells:[TextOnlyTVC] = []
            cells.append(TextOnlyTVC(style: .default, reuseIdentifier: CellType.textOnly.rawValue))
            return ResourceSection(title: resource.title, rows: 1, type: .description)
        case .contact:
            return nil
        case .address:
            var cells:[AddressTVC] = []
            for _ in resource.addresses! {
                cells.append(AddressTVC(style: .default, reuseIdentifier: CellType.address.rawValue))
            }
            return ResourceSection(title: "ADDRESS", rows: cells.count, type: .address)
        case .social:
            var cells:[SocialMediasTVC] = []
            cells.append(SocialMediasTVC(style: .default, reuseIdentifier: CellType.textOnly.rawValue))
            return ResourceSection(title: "SOCIAL NETWORKS", rows: 1, type: .social)
        case .notes:
            var cells:[TextOnlyTVC] = []
            if let allTexts = resource.freeTexts {
                for _ in allTexts {
                    cells.append(TextOnlyTVC(style: .default, reuseIdentifier: CellType.textOnly.rawValue))
                }
            }
            return ResourceSection(title: "NOTES", rows: cells.count, type: .notes)
        }
    }
}
