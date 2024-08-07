//
//  TrainingPlanExecutionRecapView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 29.06.24.
//

import SwiftUI
import SwiftData

struct TrainingPlanExecutionRecapView: View {
    @State var tpExecution: TrainingPlanExecution
    @AppStorage("activeTrainingID") private var activeTrainingID: String = ""
    var disableNavigation : Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Training Zusammenfassung")
                .font(.title)
                .fontWeight(.bold)
                .underline()
                .padding(.vertical, 15)
                .padding(.leading, 15)
            
            Text("Name: " + (tpExecution.trainingsPlan?.name ?? ""))
                .padding(.leading, 15)
                .padding(.bottom, 15)
                .font(.title2)

            let dateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, dd.MM.yy"
                dateFormatter.locale = Locale(identifier: "de_DE")
                return dateFormatter
            }()
            
            let startTime = {
                let timestamp = tpExecution.startTimeStamp
                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                let temp = DateFormatter()
                temp.dateFormat = "HH:mm"
                return temp.string(from: date)
            }
            
            let endTime = {
                let timestamp = tpExecution.endTimeStamp
                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                let temp = DateFormatter()
                temp.dateFormat = "HH:mm"
                return temp.string(from: date)
            }
            
            let dateValue = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(tpExecution.startTimeStamp)))
            
            HStack {
                Text(dateValue)
                    .padding(.leading, 15)
                Text(startTime() + " bis " + endTime())
                    .padding(.leading, 15)
            }

            Divider()
            
            List {
                ForEach(tpExecution.exerciseExecution ?? [], id: \.self) { exerciseExec in
                    VStack(alignment: .leading) {
                        Label {
                            Text(exerciseExec.exercise?.fullName ?? "Übung Name")
                                .font(.headline)
                        } icon: {
                            Image(systemName: exerciseExec.exercise?.iconName ?? "dumbbell")
                                .foregroundColor(.primary)
                        }
                        Divider()
                        ForEach(exerciseExec.exerciseExecutionSets ?? [], id: \.self) { executionSet in
                            let repPluralText = executionSet.reps == 1 ? "Wiederholung" : "Wiederholungen"
                            Text("\(executionSet.reps) \(repPluralText) zu \(executionSet.weight, specifier: "%.1f") kg")
                            Divider()
                        }
                        Text("Ausführung: " + (exerciseExec.executionScore?.description ?? "DEFAULT"))
                        Text("Erschöpfung: " + (exerciseExec.exhaustScore?.description ?? "DEFAULT"))
                    }
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.vertical, 4)
            }
            
            if disableNavigation {
                HStack {
                    Spacer()
                    Button("Verlassen") {
                        activeTrainingID = ""
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Spacer()
                } 
            }
        }
        .navigationBarBackButtonHidden(disableNavigation)
        
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: #Predicate { $0.endTimeStamp == -1})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingPlanExecutionRecapView(tpExecution: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }
    
}
