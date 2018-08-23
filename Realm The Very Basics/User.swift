import Foundation
import RealmSwift

class User: Object
{
    @objc dynamic var name: String = ""
    var comments: List<Comment> = List<Comment>()
    
    convenience init(inpName: String)
    {
        self.init()
        self.name = inpName
        self.comments = List<Comment>()
    }
}
