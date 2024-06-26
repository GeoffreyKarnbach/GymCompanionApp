//
//  TrainingPlanActiveView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 26.06.24.
//

import SwiftUI
import SwiftData

struct TrainingPlanActiveView: View {
    @Environment(\.presentationMode) var presentationMode

    var activeTrainingPlan: TrainingPlan
    var body: some View {
        NavigationStack {
            VStack {
                Text("HELLO")
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .navigationTitle(activeTrainingPlan.name)
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlan>(predicate: #Predicate { $0.name.contains("1")})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingPlanActiveView(activeTrainingPlan: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}
