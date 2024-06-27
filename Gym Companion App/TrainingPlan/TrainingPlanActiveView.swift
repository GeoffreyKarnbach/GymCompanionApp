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
    @State var currentTrainingPlanExecution: TrainingPlanExecution? = nil
    @AppStorage("activeTrainingID") private var activeTrainingID: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(currentTrainingPlanExecution?.trainingsPlan?.name ?? "DEFAULT")
                Text(currentTrainingPlanExecution?.tID ?? "DEFAULT")

                Button("Dismiss") {
                    activeTrainingID = ""
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .navigationBarBackButtonHidden(true) // Hides the back button
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: #Predicate { $0.endTimeStamp == -1})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingPlanActiveView(currentTrainingPlanExecution: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}
