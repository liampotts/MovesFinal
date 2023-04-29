//
//  RowSelectionView.swift
//  Moves
//
//  Created by Liam Potts on 4/28/23.
//

import SwiftUI

struct RowSelectionView: View {
    @State var comment: Comment
    
    var body: some View {
        Text(comment.body)
    }
}

struct RowSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RowSelectionView(comment: Comment())
    }
}
