//
//  ContentView.swift
//  Moves
//
//  Created by Liam Potts on 4/22/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ListView: View {
    
    @FirestoreQuery(collectionPath: "moves") var moves: [Move]
    
    @State private var sheetIsPresented = false
    @Environment (\.dismiss) private var dismiss
    var previewRunning = false
    @State var date = Date()
    
    var body: some View {
        VStack{
            NavigationStack {
                
                Text(Date.now, style: .date)
                
                List(moves) { move in
                    NavigationLink {
                        MoveDetailView(move: move)
        
                    } label: {
                        
                        HStack{
                            Text(move.name)
                                .font(.title2)
                            
                            Text(String(move.upvotes) + " people going")
   
                        }
                        
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Potential Moves")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out") {
                            do {
                                try Auth.auth().signOut()
                                print("Log out successful!")
                                dismiss()
                            } catch {
                                print("Error: could not sign out")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            
                            HStack{
//                                Text("Add Move")
                                Image(systemName: "plus")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                }
                .sheet(isPresented: $sheetIsPresented) {
                    NavigationStack{
                        AddMoveView(move: Move())
                    }
                }
            }
        }
        .onAppear{
                print("hi")
            print($moves.path)
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ListView()
        }
    }
}
