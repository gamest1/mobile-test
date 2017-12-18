import Foundation

public class GPS {
	public var latitude : Double?
	public var longitude : Double?

/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let gps = GPS(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: GPS Instance.
*/
	required public init?(dictionary: NSDictionary) {
        guard let lat = dictionary["latitude"] as? String,
              let lon = dictionary["longitude"] as? String
            else {  print("Problems initialitating GPS object")
                    return nil
            }
		latitude = Double(lat)
		longitude = Double(lon)
	}

/** Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.latitude, forKey: "latitude")
		dictionary.setValue(self.longitude, forKey: "longitude")

		return dictionary
	}
}
