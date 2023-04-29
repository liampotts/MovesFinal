//
//  MoveDetailView.swift
//  Moves
//
//  Created by Liam Potts on 4/22/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct MoveDetailView: View {
    
    @EnvironmentObject var moveVM: MoveViewModel
    @State var move: Move
    
    //THIS IS ONE OF THE LINES THAT IS CAUSING THE ERROR
//    @FirestoreQuery(collectionPath: "moves") var comments: [Comment]
    
    
    
    @Environment (\.dismiss) private var dismiss
    var previewRunning = false
    @State private var showCommentViewSheet = false
    @State private var showSaveAlert = false
    @State private var showingAsSheet = false
    
    //THIS IS JUST FROM ME TESTING
//    var comments: [Comment] = [Comment(body: "hi")]
    
    var body: some View {
        VStack {
            Text(move.name)
                .bold()
                .font(.title2)
            
            Text("\(move.upvotes) people going so far")
            
            VStack {
                
                HStack{
                    Text("Guest List:")
                        .bold()
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                                    //TODO add user to guest list
                                 }, label: {
                                     
                                     Text("I'm Going!")
                                     Image(systemName: "hand.thumbsup")
                                 })
                    .padding()
//                    .buttonStyle(.borderedProminent)
                    
                }
                
                
                HStack{
                    
                    
                    Text("Comments:")
                        .bold()
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                                     if move.id == nil{
                                         showSaveAlert.toggle()
                                     } else {
                                         showCommentViewSheet.toggle()
                                     }
                                 }, label: {
                                     Image(systemName: "square.and.pencil")
                                     Text("Add Comment")
                                         .minimumScaleFactor(0.5)
                                     
                                 })
                    .padding()
                   
                    
                   
                }
                
            }
            
            List {
                Section {
                    ForEach(move.comments) { comment in
                        NavigationLink {
                            CommentView(move: move, comment: comment)
                            
//                            TestView()
                        } label: {
                            Text("hi")
                        }
                    }
                }
            }
            .listStyle(.plain)

            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .onAppear {
            
            if !previewRunning && move.id != nil {
//                $comments.path = "moves/\(move.id ?? "")/comments"
//                print("comments.path = \($comments.path)")
                print("comments = \(move.comments)")
            } else { //move.id starts out as nil
                showingAsSheet = true
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(move.id == nil)
        .toolbar {
            if showingAsSheet {
                if  move.id == nil && showingAsSheet { // New spot, so show Cancel/Save buttons
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            
                            Task {
                                let success = await moveVM.saveMove(move: move)
                                if success {
                                    dismiss()
                                    
                                } else {
                                    print("😡 DANG! Error saving spot!")
                                }
                            }
                            dismiss()
                        }
                    }
                    
                }
                else if showingAsSheet && move.id != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done"){
                            dismiss()
                        }
                    }
                }
            }
            
        }
        .sheet(isPresented: $showCommentViewSheet) {
            NavigationStack{
                CommentView(move: move, comment: Comment())
//                TestView()
            }
        }
    }
}

struct MoveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MoveDetailView(move: Move(), previewRunning: true)
                .environmentObject(MoveViewModel())
        }
    }
}
