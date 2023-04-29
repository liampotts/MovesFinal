//
//  Move.swift
//  Moves
//
//  Created by Liam Potts on 4/22/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Move: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var upvotes = "0"
//    var postedOn = Date()
    var postedBy = ""
    var description = ""
    var guestList: [String] = []
    var comments: [String] = []
    
    
    var dictionary: [String: Any] {
       
        return ["name": name, "upvotes": upvotes, "description": description, "postedBy": Auth.auth().currentUser?.email ?? "", "guestList": guestList, "comments": comments]
        
    }
    
}

//, "postedOn": Timestamp(date: Date())
