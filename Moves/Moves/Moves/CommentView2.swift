//
//  CommentView2.swift
//  Moves
//
//  Created by Liam Potts on 4/28/23.
//

import SwiftUI

struct CommentView2: View {
    @State var move: Move
    @State var index: Int
    
    var body: some View {
        Text(move.comments[index])
    }
}

struct CommentView2_Previews: PreviewProvider {
    static var previews: some View {
        CommentView2(move: Move(), index: 0)
    }
}
