

import SwiftUI

struct IsGoingSelectionView: View {
    @State var isGoing: Bool
    @State var interactive = true
//    let highestRating = 5
    let unselected = "hand.thumbsup"
    let selected = "hand.thumbsup.fill"
    var font: Font = .largeTitle
    let fillColor: Color = .red
    let emptyColor: Color = .gray
    
    
    var body: some View {
//        HStack {
//            ForEach(1...highestRating, id: \.self) { number in
//
//                showStar(for: number)
//                    .foregroundColor(number<=rating ? fillColor : emptyColor)
//                    .onTapGesture {
//                        if interactive {
//                            rating = number
//                        }
//
//                    }
//            }
//            .font(font)
//        }
        
        
        HStack {
            Image(systemName: isGoing ? unselected: selected)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        .onTapGesture {
            isGoing = !isGoing
        }
        
        
        
    }
    
//    func showStar( for number: Int) -> Image {
//        if number>rating {
//            return unselected
//        } else {
//            return selected
//        }
//    }
}

struct StarsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        IsGoingSelectionView(isGoing: false)
    }
}
