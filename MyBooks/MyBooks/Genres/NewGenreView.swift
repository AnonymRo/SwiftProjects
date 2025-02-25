//
//  NewGenreView.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 25/2/25.
//

import SwiftUI
import SwiftData

struct NewGenreView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var color = Color.red
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                ColorPicker("Set the genre color", selection: $color, supportsOpacity: false)
                Button("Create") {
                    let newGenre = Genre(name: name, color: color.toHexString()!)
                    context.insert(newGenre)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("New Genre")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewGenreView()
}
