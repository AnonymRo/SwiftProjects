//
//  RatingView.swift
//  Bookworm
//
//  Created by Sebastian Bușa on 11/2/25.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    var isEditable = true
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                if isEditable {
                    Button {
                        rating = number
                    } label: {
                        image(for: number)
                            .foregroundStyle(number > rating ? offColor : onColor)
                    }
                    .buttonStyle(.plain)
                } else {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
