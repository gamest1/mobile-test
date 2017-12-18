import Foundation
 
public class SocialMedia {
	public var youtubeChannel : Array<String>?
	public var twitter : Array<String>?
	public var facebook : Array<String>?

    // Returns an array of Strings(URLs) based on given dictionary.
    public class func stringsFromDictionaryArray(array:NSArray) -> [String] {
        var strings:[String] = []
        for item in array {
            strings.append(item as! String)
        }
        return strings
    }

/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let socialMedia = SocialMedia(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: SocialMedia Instance.
*/
	required public init?(dictionary: NSDictionary) {
		if (dictionary["youtubeChannel"] != nil) {
            youtubeChannel = SocialMedia.stringsFromDictionaryArray(array: dictionary["youtubeChannel"] as! NSArray)
        }
        if (dictionary["twitter"] != nil) {
            twitter = SocialMedia.stringsFromDictionaryArray(array: dictionary["twitter"] as! NSArray)
        }
        if (dictionary["facebook"] != nil) {
            facebook = SocialMedia.stringsFromDictionaryArray(array: dictionary["facebook"] as! NSArray)
        }
	}

		
/** Returns the dictionary representation for the current instance.

    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.youtubeChannel, forKey: "youtubeChannel")
        dictionary.setValue(self.twitter, forKey: "twitter")
        dictionary.setValue(self.facebook, forKey: "facebook")
        
		return dictionary
	}
    
    public func rowsNeeded() -> Int {
        var resp = 0
        if let num = youtubeChannel?.count, num > 0 {
            resp += num
        }
        if let num = twitter?.count, num > 0 {
            resp += num
        }
        if let num = facebook?.count, num > 0 {
            resp += num
        }
        return resp
    }
}
