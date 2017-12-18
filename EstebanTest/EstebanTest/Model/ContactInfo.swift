import Foundation

public class ContactInfo {
	public var websites     : Array<ContactTypeItem>?
	public var emails       : Array<ContactTypeItem>?
	public var phoneNumbers : Array<ContactTypeItem>?
    public var faxNumbers   : Array<ContactTypeItem>?
    public var tollFrees    : Array<ContactTypeItem>?
    
/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let contactInfo = ContactInfo(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: ContactInfo Instance.
*/
	required public init?(dictionary: NSDictionary) {
		if (dictionary["website"] != nil) {
            websites = (dictionary["website"] as! NSArray).toContactItem(type: .website)
        }
		if (dictionary["email"] != nil) {
            emails = (dictionary["email"] as! NSArray).toContactItem(type: .email)
        }
		if (dictionary["phoneNumber"] != nil) {
            phoneNumbers = (dictionary["phoneNumber"] as! NSArray).toContactItem(type: .phone)
        }
        if (dictionary["faxNumber"] != nil) {
            faxNumbers = (dictionary["faxNumber"] as! NSArray).toContactItem(type: .fax)
        }
        if (dictionary["tollFree"] != nil) {
            tollFrees = (dictionary["tollFree"] as! NSArray).toContactItem(type: .tollfree)
        }
    }

		
/** Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

        if self.websites != nil {
            dictionary.setValue(self.websites!.toStrings(), forKey: "website")
        }
        if self.emails != nil {
            dictionary.setValue(self.emails!.toStrings(), forKey: "email")
        }
        if self.phoneNumbers != nil {
            dictionary.setValue(self.phoneNumbers!.toStrings(), forKey: "phoneNumber")
        }
        if self.faxNumbers != nil {
            dictionary.setValue(self.faxNumbers!.toStrings(), forKey: "faxNumber")
        }
        if self.tollFrees != nil {
            dictionary.setValue(self.tollFrees!.toStrings(), forKey: "tollFree")
        }
		return dictionary
	}

// The order here establishes the order in the Contact Info Section:
// Websites first, emails then, phone numbers, fax, and toll frees in that order!
    public func contactTypeItemForRow(idx : Int) -> ContactTypeItem? {
        var resp = 0
        var previous = 0
        if let num = websites?.count, num > 0 {
            previous = resp
            resp += num
        }
        if idx < resp {
            return ContactTypeItem(string: self.websites![idx-previous].string, type: .website)
        }
        if let num = emails?.count, num > 0 {
            previous = resp
            resp += num
        }
        if idx < resp {
            return ContactTypeItem(string: self.emails![idx-previous].string, type: .email)
        }
        if let num = phoneNumbers?.count, num > 0 {
            previous = resp
            resp += num
        }
        if idx < resp {
            return ContactTypeItem(string: self.phoneNumbers![idx-previous].string, type: .phone)
        }
        if let num = faxNumbers?.count, num > 0 {
            previous = resp
            resp += num
        }
        if idx < resp {
            return ContactTypeItem(string: self.faxNumbers![idx-previous].string, type: .fax)
        }
        if let num = tollFrees?.count, num > 0 {
            previous = resp
            resp += num
        }
        if idx < resp {
            return ContactTypeItem(string: self.tollFrees![idx-previous].string, type: .tollfree)
        }
        return nil
    }
    
    public func rowsNeeded() -> Int {
        var resp = 0
        if let num = websites?.count, num > 0 {
            resp += num
        }
        if let num = emails?.count, num > 0 {
            resp += num
        }
        if let num = phoneNumbers?.count, num > 0 {
            resp += num
        }
        if let num = faxNumbers?.count, num > 0 {
            resp += num
        }
        if let num = tollFrees?.count, num > 0 {
            resp += num
        }
        return resp
    }
}
