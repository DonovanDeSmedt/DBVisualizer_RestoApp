import Foundation
import FirebaseDatabase

struct Restaurant {
    
    let key: String!
    let naam: String!
    let campus: String!
    let bezetting: Int!
    let beschikbaarheid: Int!
    let itemRef: FIRDatabaseReference?
    
    
    init(){
        self.key = ""
        self.naam = ""
        self.campus = ""
        self.bezetting = 0
        self.beschikbaarheid = 0
        self.itemRef = nil
    }
    
    init (naam: String, campus: String, key: String = "") {
        self.key = key
        self.naam = naam
        self.campus = campus
        self.bezetting = 0
        self.beschikbaarheid = 0
        self.itemRef = nil
    }
    
    init (snapshot: FIRDataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        let snapshotValue = snapshot.value as? NSDictionary

        if let naam = snapshotValue?["naam"] as? String {
            self.naam = naam
        } else{
            self.naam = ""
        }
        
        if let campus = snapshotValue?["campus"] as? String {
            self.campus = campus
        } else{
            self.campus = ""
        }
        if let bezetting = snapshotValue?["bezetting"] as? Int {
            self.bezetting = bezetting
        } else{
            self.bezetting = 0
        }
        if let beschikbaarheid = snapshotValue?["beschikbaarheid"] as? Int {
            self.beschikbaarheid = beschikbaarheid
        } else{
            self.beschikbaarheid = 0
        }
    }
    
    func toAnyObject() -> AnyObject {
        return ["naam": naam, "campus": campus, "bezetting": bezetting, "beschikbaarheid": beschikbaarheid] as AnyObject
    }
    
}
