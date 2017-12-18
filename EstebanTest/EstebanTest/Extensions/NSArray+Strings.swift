//
//  NSArray+Strings.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-09.
//  Copyright © 2017 Transcriptics. All rights reserved.
//

import Foundation

extension Array {
    func toStrings() -> [String] {
        var strings:[String] = []
        for item in self {
            if let contactType = item as? ContactTypeItem {
                // item is a ContactTypeItem.
                strings.append(contactType.string)
            }
            else {
                strings.append(item as! String)
            }
        }
        return strings
    }
}

extension NSArray {
    func toStrings() -> [String] {
        var strings:[String] = []
        for item in self {
            strings.append(item as! String)
        }
        return strings
    }
    
    func toContactItem(type: ContactType) -> [ContactTypeItem] {
        var strings:[ContactTypeItem] = []
        for item in self {
            strings.append(ContactTypeItem(string: item as! String, type: type))
        }
        return strings
    }
}
