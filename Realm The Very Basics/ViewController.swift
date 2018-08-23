import UIKit
import RealmSwift


class ViewController: UIViewController
{
    var readFirstUser: User?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        writeUser()
        
        
        deleteAll()
        
        realmRead()
        writeUser()
        
        print(#line, "This is after Write")
        realmRead()

        
        let amirUser = User (inpName: "Amir")

        deleteCommentAt(itemIndex: 0,
                        fromUser: amirUser)
        print(#line, "This is after comment delete")
        realmRead()
        print (amirUser.comments.count)

        
        let newComment = Comment(inpText: "He messed me up")
        writeComment(inpComment: newComment,
                     inpUser: amirUser)
        print(#line, "This is after comment addition")
        realmRead()

        
        
         deleteUser(inpUser: amirUser)
         print(#line, "This is after delete")
         realmRead()
    }
    
    private func writeUser()
    {
        let thisUser = User (inpName: "Steve")
        let thisUserComment_1 = Comment(inpText: "whatever")
        thisUser.comments.append(thisUserComment_1)

        do
        {
            let realm = try Realm()
            try realm.write
            {
                realm.add(thisUser)
            }
        }
        catch
        {
            print("Error encountered")
        }
    }
    
    func deleteAll ()
    {
        let realm = try! Realm()
        try! realm.write
        {
            realm.deleteAll()
        }
    }
    
    
    func deleteUser (inpUser: User)
    {
        do
        {
            let realm = try Realm()
            let userObject = realm.objects(User.self).filter("name = '\(inpUser.name)'").first!
            
            try! realm.write
            {
                // should delete the right list
                realm.delete(userObject)
            }
        }
        catch
        {
            print("Error encountered")
        }
    }
    
    
    
    
    
    
    func deleteCommentAt (itemIndex: Int,
                          fromUser: User)
    {
        do
        {
            let realm = try Realm()
            
            let userObject = realm.objects(User.self).filter("name = '\(fromUser.name)'").first!
            
            try! realm.write
            {
                // for single item
                realm.delete(userObject.comments[itemIndex])
            }
        }
        catch
        {
            print("Error encountered")
        }
    }
    
    
    func writeComment (inpComment: Comment,
                       inpUser: User)
    {
        do
        {
            let realm = try Realm()
            
            let userObject = realm.objects(User.self).filter("name = '\(inpUser.name)'").first!
            
            try! realm.write
            {
                userObject.comments.append(inpComment)
            }
        }
        catch
        {
            print("Error encountered")
        }
    }
    
    
    private func realmRead()
    {
        guard let realm = try? Realm() else
        {
            print("Error in Reading")
            return
        }
        
        let resultsList = realm.objects(User.self)
        
        for anyUser in resultsList
        {
            print(#line, anyUser.name)
            print(#line, anyUser.comments )
        }
    }
}
