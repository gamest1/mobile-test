import Foundation

//This class may be finished later as more information about the FreeText structure becomes available.
//Right now, it's just a placeholder for a dictionary
public class FreeText {
    
/** Returns an array of freeTexts based on given dictionary.
     
     Sample usage:
     let addresses_list = FreeText.textsFromArray(someDictionaryArrayFromJSON)
     - parameter array:  NSArray from JSON dictionary.
     - returns: Array of freeText Instances.
     */
    public class func textsFromArray(array:NSArray) -> [FreeText] {
        var txts:[FreeText] = []
        for item in array {
            txts.append(FreeText(dictionary: item as! NSDictionary)!)
        }
        return txts
    }
    
/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let freeText = FreeText(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: FreeText Instance.
*/
	required public init?(dictionary: NSDictionary) {
	}

		
/** Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
        return dictionary
	}
    
    func toString() -> String {
        return ""
    }
}
