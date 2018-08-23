import Foundation
import RealmSwift


class Comment: Object
{
    @objc dynamic var text: String?
    
    convenience init(inpText: String)
    {
        self.init()
        self.text = inpText
    }
}
