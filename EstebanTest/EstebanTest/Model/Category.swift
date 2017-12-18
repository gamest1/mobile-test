import Foundation

public class Category {
    public var id : String
    public var type : String
    public var title : String
    public var description : String?
    public var isActive : Bool
    public var updated_at : Date

/** Returns an array of Categories based on given dictionary.
    
    Sample usage:
    let Categories_list = Category.categoriesFromArray(someArrayFromJSON)
    - parameter array:  NSArray from JSON dictionary.
    - returns: Array of Category Instances.
*/
    public class func categoriesFromArray(array:NSArray) -> [Category] {
        var cats:[Category] = []
        for item in array {
            cats.append(Category(dictionary: item as! NSDictionary)!)
        }
        return cats
    }

/** Constructs the object based on the given dictionary.
    
    Sample usage:
    let Category = Category(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: Category Instance.
*/
	required public init?(dictionary: NSDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.backendDateFormat
        
		id           = dictionary["_id"] as! String
        updated_at   = dateFormatter.date(from: dictionary["updated_at"] as! String)!
        type         = dictionary["slug"] as! String
		title        = dictionary["title"] as! String
		description  = dictionary["description"] as? String
		isActive      = (dictionary["_active"] as! Int) == 1
	}

		
/** Returns the dictionary representation for the current instance.
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.backendDateFormat
        
		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "_id")
        dictionary.setValue(dateFormatter.string(from: self.updated_at), forKey: "updated_at")
        dictionary.setValue(self.type, forKey: "slug")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.isActive, forKey: "_active")

		return dictionary
	}

}
