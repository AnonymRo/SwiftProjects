//
//  StepperView.swift
//  Questions
//
//  Created by Sebastian Bușa on 3/1/25.
//

import SwiftUI

struct StepperView: View {
    
    @Binding var questionsCount: Int
    
    var body: some View {
        HStack {
            Stepper("Enter a number", value: $questionsCount, in: 0...10, step: 1)
                .font(.title3)
            
            Text("\(questionsCount)")
                .font(.title2)
                .foregroundStyle(.primary)
                .padding(5)
        }
    }
}

#Preview {
    @Previewable @State var previewQuestionsCount: Int = 1
    StepperView(questionsCount: $previewQuestionsCount)
}
