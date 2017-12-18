//  Resource.swift
//  EstebanTest
//
//  Created by Esteban on 2017-11-09.
//  Copyright © 2017 Transcriptics. All rights reserved.

import Foundation

public class Resource {
    public var sourceURL : String?
    
    public var id           : String
    public var slug         : String
    public var photoLink    : String?
    public var title        : String
    public var description  : String?
    public var isActive     : Bool
    public var updated_at   : Date
    public var socialMedia  : SocialMedia?
    public var addresses    : Array<Address>?
    public var freeTexts    : Array<FreeText>?
    public var contactInfo  : ContactInfo?
    
    /** Returns an array of models based on given dictionary.
     
     Sample usage:
     let Resources_list = Resource.modelsFromArray(someDictionaryArrayFromJSON)
     - parameter array:  NSArray from JSON dictionary.
     - returns: Array of Resource Instances.
     */
    public class func resourcesFromArray(array:NSArray) -> [Resource] {
        var res:[Resource] = []
        for item in array {
            res.append(Resource(dictionary: item as! NSDictionary)!)
        }
        return res
    }
    
    /** Constructs the object based on the given dictionary.
     
     Sample usage:
     let Resources = Resources(someDictionaryFromJSON)
     - parameter dictionary:  NSDictionary from JSON.
     - returns: Resources Instance.
     */
    required public init?(dictionary: NSDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.backendDateFormat
        
        id          = dictionary["_id"] as! String
        slug        = dictionary["slug"] as! String
        photoLink   = dictionary["photo"] as? String
        title       = dictionary["title"] as! String
        description = dictionary["description"] as? String
        isActive    = (dictionary["_active"] as! Int) == 1
        updated_at  = dateFormatter.date(from: dictionary["updated_at"] as! String)!
        
        
        if (dictionary["socialMedia"] != nil) {
            socialMedia = SocialMedia(dictionary: dictionary["socialMedia"] as! NSDictionary)
        }
        if (dictionary["addresses"] != nil) {
            addresses = Address.addressesFromArray(array: dictionary["addresses"] as! NSArray)
        }
        if (dictionary["freeText"] != nil) {
            freeTexts = FreeText.textsFromArray(array: dictionary["freeText"] as! NSArray)
        }
        if (dictionary["contactInfo"] != nil) {
            contactInfo = ContactInfo(dictionary: dictionary["contactInfo"] as! NSDictionary)
        }
    }
    
    /** Returns the dictionary representation for the current instance.
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.backendDateFormat
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.id, forKey: "_id")
        dictionary.setValue(self.slug, forKey: "slug")
        dictionary.setValue(self.photoLink, forKey: "photo")
        dictionary.setValue(self.title, forKey: "title")
        dictionary.setValue(self.description, forKey: "description")
        dictionary.setValue(self.isActive, forKey: "_active")
        dictionary.setValue(dateFormatter.string(from: self.updated_at), forKey: "updated_at")
        dictionary.setValue(self.socialMedia?.dictionaryRepresentation(), forKey: "socialMedia")
        dictionary.setValue(self.contactInfo?.dictionaryRepresentation(), forKey: "contactInfo")

        //We may need to create methods to encode these two:
        //dictionary.setValue(self.addresses, forKey: "addresses")
        //dictionary.setValue(self.freeTexts, forKey: "freeText")
        
        return dictionary
    }
    
    func sections() -> [ResourceSection] {
        var resp:[ResourceSection] = []
        if photoLink != nil,
           let sec = ResourceSection(title: "PHOTOS", rows: 1, type: .photo) {
           resp.append(sec)
        }
        if description != nil,
           let sec = ResourceSection(title:title, rows: 1, type: .description) {
            resp.append(sec)
        }
        if let num = contactInfo?.rowsNeeded(), num > 0,
           let sec = ResourceSection(title:"CONTACT INFORMATION", rows: num, type: .contact) {
            resp.append(sec)
        }
        if let num = addresses?.count, num > 0,
            let sec = ResourceSection(title:"ADDRESS", rows: num, type: .address) {
            resp.append(sec)
        }
        if let num = socialMedia?.rowsNeeded(), num > 0,
            let sec = ResourceSection(title:"SOCIAL NETWORKS", rows: 1, type: .social) {
            resp.append(sec)
        }
        if let num = freeTexts?.count, num > 0,
            let sec = ResourceSection(title:"NOTES", rows: num, type: .notes) {
            resp.append(sec)
        }
        return resp
    }
    
}
