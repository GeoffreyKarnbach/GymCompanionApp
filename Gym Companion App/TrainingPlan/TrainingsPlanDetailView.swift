//
//  TrainingsPlanDetailView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 04.07.24.
//

import SwiftUI
import SwiftData

struct TrainingsPlanDetailView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("activeTrainingID") private var activeTrainingID: String = ""
    
    @State private var newTrainingPlanExecution: TrainingPlanExecution?
    
    var trainingsplan: TrainingPlan
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(trainingsplan.name)
                .font(.title)
                .fontWeight(.bold)
                .underline()
                .padding(.vertical, 15)
            Text(trainingsplan.days)
                .padding(.bottom, 15)

            Text("Übungsanzahl: " + (trainingsplan.exerciseInTraining?.count.description ?? "0" ))
            Divider()
            Text("Durchführungen:")
                .fontWeight(.bold)
                .underline()
                .padding(.vertical, 15)
            ScrollView {
                
                
                VStack(alignment: .leading) {
                    ForEach((trainingsplan.trainingPlanExecutions?.sorted(by: { $0.startTimeStamp > $1.endTimeStamp }) ?? []), id: \.self) { tpExec in
                        NavigationLink(destination: TrainingPlanExecutionRecapView(tpExecution: tpExec, disableNavigation: false)) {
                            
                            let dateFormatter = {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "EEEE, dd.MM.yy"
                                dateFormatter.locale = Locale(identifier: "de_DE")
                                return dateFormatter
                            }()
                            
                            let startTime = {
                                let timestamp = tpExec.startTimeStamp
                                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                                let temp = DateFormatter()
                                temp.dateFormat = "HH:mm"
                                return temp.string(from: date)
                            }
                            
                            let endTime = {
                                let timestamp = tpExec.endTimeStamp
                                let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                                let temp = DateFormatter()
                                temp.dateFormat = "HH:mm"
                                return temp.string(from: date)
                            }
                            
                            let dateValue = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(tpExec.startTimeStamp)))
                            let timeValue = startTime() + " - " + endTime()
                            
                            HStack{
                                Text(dateValue)
                                Spacer()
                                Text(timeValue)
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 15)
                        }
                    }
                }
            }
            Divider()
            
            if (trainingsplan.exerciseInTraining?.count ?? 0) > 0 {
                Button(action: {
                    newTrainingPlanExecution = TrainingPlanExecution(startTimeStamp: Int32(Date().timeIntervalSince1970), endTimeStamp: -1, trainingsPlan: trainingsplan, exerciseExecution: [])
                    
                    context.insert(newTrainingPlanExecution!)
                    
                    try! context.save()
                    print(newTrainingPlanExecution!.tID)
                    activeTrainingID = newTrainingPlanExecution!.tID
                }) {
                    Label("STARTEN", systemImage: "play.circle.fill")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.trailing, 15)
            }
            
            Spacer()
            
            Text("Statistik:")
                .fontWeight(.bold)
                .underline()
                .padding(.vertical, 15)
            Text("Gesamtanzahl Trainings: " + (trainingsplan.trainingPlanExecutions?.count.description ?? "0"))
            Text("Durschnittliche Dauer: TODO")
                .padding(.bottom, 20)
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: TrainingsPlanEditView(trainingsplan: trainingsplan)) {
                    Image(systemName: "pencil")
                }
            }
        }
        .padding(.leading, 10)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlan>(predicate: #Predicate { $0.name.contains("1")})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingsPlanDetailView(trainingsplan: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }
    
}
