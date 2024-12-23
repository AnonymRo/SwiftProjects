//
//  FlagImageView.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 18/12/24.
//

import SwiftUI

struct FlagImageView: View {
    
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 10)
    }
}

#Preview {
    FlagImageView(imageName: "Ukraine")
}
