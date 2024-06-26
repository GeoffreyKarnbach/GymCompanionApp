//
//  TrainingsPlanActiveView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 26.06.24.
//

import SwiftUI
import SwiftData

struct TrainingsPlanActiveView: View {
    var currentTrainingsPlan: TrainingPlan
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlan>(predicate: #Predicate { $0.name.contains("1")})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingsPlanActiveView(currentTrainingsPlan: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}
