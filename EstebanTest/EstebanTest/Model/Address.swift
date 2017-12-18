import Foundation
 
public class Address {
	public var address1 : String?
	public var label    : String?
	public var zipCode  : String?
	public var city     : String?
	public var state    : String?
	public var country  : String?
	public var gps      : GPS?

/** Returns an array of models based on given dictionary.
    
    Sample usage:
    let addresses_list = Address.addressesFromArray(someDictionaryArrayFromJSON)
    - parameter array:  NSArray from JSON dictionary.
    - returns: Array of Addresses Instances.
*/
    public class func addressesFromArray(array:NSArray) -> [Address] {
        var addresses:[Address] = []
        for item in array {
            addresses.append(Address(dictionary: item as! NSDictionary)!)
        }
        return addresses
    }

/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let address = Address(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: Address Instance.
*/
	required public init?(dictionary: NSDictionary) {
		address1 = dictionary["address1"] as? String
		label    = dictionary["label"] as? String
		zipCode  = dictionary["zipCode"] as? String
		city     = dictionary["city"] as? String
		state    = dictionary["state"] as? String
		country  = dictionary["country"] as? String
		if (dictionary["gps"] != nil) {
            gps = GPS(dictionary: dictionary["gps"] as! NSDictionary)
        }
	}

		
/** Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.address1, forKey: "address1")
		dictionary.setValue(self.label, forKey: "label")
		dictionary.setValue(self.zipCode, forKey: "zipCode")
		dictionary.setValue(self.city, forKey: "city")
		dictionary.setValue(self.state, forKey: "state")
		dictionary.setValue(self.country, forKey: "country")
		dictionary.setValue(self.gps?.dictionaryRepresentation(), forKey: "gps")

		return dictionary
	}

}
