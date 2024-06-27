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
                Text(currentTrainingPlanExecution?.trainingsPlan?.name ?? "NAME")
                Text(currentTrainingPlanExecution?.trainingsPlan?.days ?? "TAGE")
                
                
                if let exercises = currentTrainingPlanExecution?.trainingsPlan?.exerciseInTraining {
                    List {
                        ForEach(exercises.sorted(by: {
                            $0.order < $1.order
                        }), id: \.self) { exercise in
                            TrainingsPlanSingleExerciseView(exercise: exercise, isActiveTrainingView: true, exerciseCompleted: true)
                                .padding(.horizontal)
                            
                        }
                    }
                }
                
                let formattedTime = {
                    let timestamp = currentTrainingPlanExecution?.startTimeStamp ?? 0
                    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                    let temp = DateFormatter()
                    temp.dateFormat = "HH:mm"
                    return temp.string(from: date)
                }
                
                Text("Startuhrzeit: " + formattedTime())
                
                let timeDifference = {
                    let timestamp = currentTrainingPlanExecution?.startTimeStamp ?? 0
                    
                    let difference = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(timestamp)))
                    
                    let hours = Int(difference / 3600)
                    let minutes = Int((difference / 60).truncatingRemainder(dividingBy: 60))
                    
                    // Format the time difference as "hh:mm"
                    let formattedTime = String(format: "%02d:%02d", hours, minutes)
                    
                    return formattedTime
                    
                }
                Text("Dauer: " + timeDifference())
                
                Button("Training abschließen") {
                    activeTrainingID = ""
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.top, 20)
                .padding(.bottom, 10)


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
