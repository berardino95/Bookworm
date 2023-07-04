//
//  RatingView.swift
//  Bookworm
//
//  Created by Berardino Chiarello on 22/05/23.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage : Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
                Spacer()
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
            //Ignore default screen reader info
            .accessibilityElement()
            //add custom accessibility info
            .accessibilityLabel("Rating")
            .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
            //Custom gesture action when using screen reader
            .accessibilityAdjustableAction{ direction in
                switch direction {
                case .decrement:
                    if rating > 1 { rating -= 1 }
                case .increment:
                    if rating < maximumRating { rating += 1 }
                default:
                    break
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
