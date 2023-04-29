//
//  MoveViewModel.swift
//  Moves
//
//  Created by Liam Potts on 4/22/23.
//

import Foundation
import FirebaseFirestore
import Firebase

@MainActor

class MoveViewModel: ObservableObject {
    @Published var move = Move()
    
    func saveMove(move: Move) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = move.id {
            do {
                try await db.collection("moves").document(id).setData(move.dictionary)
                print("😎 Data updated successfully")
                return true
            } catch {
                print("😡 ERROR: could not update data in 'moves ")
                return false
            }
            
        } else {
            do {
              let documentRef =  try await db.collection("moves").addDocument(data: move.dictionary)
                self.move = move
                self.move.id = documentRef.documentID
                
                print("😎 Data added successfully")
                return true
            } catch {
                print("😡 ERROR: Could not create new move in 'moves")
                return false
            }
        }
    }
    
    func addUpvote(move: Move){
        
        
        return
        
    }
    
    func addComment(move: Move, comment: Comment) async -> Bool {
        let db = Firestore.firestore()
        
        guard let moveID = move.id else {
            print("😡 ERROR: Move does not have an ID")
            return false
        }
        
        var updatedMove = move
        
        updatedMove.comments.append(comment)
        
        do {
            try await db.collection("moves").document(moveID).setData(updatedMove.dictionary)
            self.move = updatedMove
            print("😎 Comment added successfully")
            return true
        } catch {
            print("😡 ERROR: Could not add comment to move in 'moves")
            return false
        }
    }

    

}
