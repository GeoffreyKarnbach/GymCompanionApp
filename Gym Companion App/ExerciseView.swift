//
//  ExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 23.06.24.
//

import SwiftUI
import SwiftData
import Charts

struct ExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var isShowingExerciseEditScreen: Bool = false
    
    @State private var showRecapView = false
    @State private var selectedExecution: ExerciseExecution?
    
    var exercise: Exercise
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(exercise.fullName)
                    .font(.title)
                    .fontWeight(.bold)
                    .underline()
                    .padding(.vertical, 15)
                Text(exercise.name)
                Text(exercise.category?.name ?? "TEST")
                Divider()
                if (exercise.inTrainings?.count ?? 0) > 0 {
                    Text("Übung in Trainingsplänen:")
                        .fontWeight(.bold)
                        .underline()
                        .padding(.vertical, 15)
                    VStack {
                        ForEach((exercise.inTrainings?.sorted{($0.trainingPlan?.name ?? "") < ($1.trainingPlan?.name ?? "")})!, id: \.self) { execInTp in
                            if let tp = execInTp.trainingPlan {
                                NavigationLink(destination: TrainingsPlanDetailView(trainingsplan: tp)) {
                                    HStack {
                                        Spacer()
                                        Text(execInTp.trainingPlan?.name ?? "DEFAULT TRAININGSPLAN NAME")
                                        Spacer()
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
                }
                
                if (exercise.executions?.count ?? 0) > 1 {
                    Spacer()
                    Divider()
                    Text("Gewichte:")
                        .fontWeight(.bold)
                        .underline()
                        .padding(.vertical, 15)
                    if let executions = exercise.executions {
                        ExerciseEvolveChart(executions: executions)
                    }
                }
                
                if (exercise.executions?.count ?? 0) > 0 {
                    Spacer()
                    Divider()
                    Text("Ausführungen:")
                        .fontWeight(.bold)
                        .underline()
                        .padding(.vertical, 15)
                    
                    let sortedExecutions = (exercise.executions ?? []).sorted {
                        ($0.trainingPlanExecution?.startTimeStamp ?? 0) > ($1.trainingPlanExecution?.startTimeStamp ?? 0)
                    }
                    
                    ForEach(sortedExecutions, id: \.self) { execution in
                        Button(action: {
                            showRecap(for: execution)
                        }) {
                            HStack {
                                Spacer()
                                
                                let dateFormatter = {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "EEEE, dd.MM.yy"
                                    dateFormatter.locale = Locale(identifier: "de_DE")
                                    return dateFormatter
                                }()
                                
                                let startTime = {
                                    let timestamp = execution.trainingPlanExecution?.startTimeStamp ?? 0
                                    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                                    let temp = DateFormatter()
                                    temp.dateFormat = "HH:mm"
                                    return temp.string(from: date)
                                }
                                
                                let endTime = {
                                    let timestamp = execution.trainingPlanExecution?.endTimeStamp ?? 0
                                    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
                                    let temp = DateFormatter()
                                    temp.dateFormat = "HH:mm"
                                    return temp.string(from: date)
                                }
                                
                                let dateValue = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(execution.trainingPlanExecution?.startTimeStamp ?? 0)))
                                
                                Text(dateValue)
                                Spacer()
                                Text(startTime() + " - " + endTime())
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.trailing, 15)
                        }
                        
                    }
                }
                Spacer()
                
            }
            .toolbar {
                if !exercise.isDefault {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingExerciseEditScreen = true
                        }) {
                            Image(systemName: "pencil.circle")
                        }
                        Button(action: {
                            context.delete(exercise)
                        }) {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingExerciseEditScreen) { EditCustomExercise(exercise: exercise) }
            .padding(.leading, 15)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedExecution) { execution in
                let presentationHeight : CGFloat = 100 + 50 * CGFloat((execution.exerciseExecutionSets?.count ?? 0))
                ExerciseExecutionRecapView(exerciseExec: execution)
                    .presentationDetents([.height(presentationHeight)])
            }
        }
    }
    
    func showRecap(for execution: ExerciseExecution) {
        selectedExecution = execution
        showRecapView = true
    }
    
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<Exercise>(predicate: #Predicate { $0.name.contains("1")})
        
        let exec1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        ExerciseView(exercise: exec1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }
}

struct EditCustomExercise: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Bindable var exercise: Exercise
    @State var categoryName: String = "Arme"
    
    @Query private var categories: [ExerciseCategory]
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Kurzer Name", text: $exercise.name)
                TextField("Langer Name", text: $exercise.fullName)
                Picker("Kategorie", selection: $categoryName) {
                    ForEach(categories.sorted(by: { $0.name < $1.name }), id: \.self) {
                        Text($0.name).tag($0.name)
                    }
                }
            }
            .navigationTitle("Neue Übung")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Speichern") {
                        
                        let selectedCategory = categories.first(where: {$0.name == categoryName})
                        
                        self.exercise.category = selectedCategory
                        
                        dismiss()
                    }
                }
            }
            
        }
        .onAppear {
            self.categoryName = self.exercise.category?.name ?? "Arme"
        }
        
    }
}

struct DataPoint : Identifiable {
    let id = UUID()
    let timestamp: Date
    let weight: Float
}

struct ExerciseEvolveChart: View {
    
    var executions: [ExerciseExecution]
    
    var body: some View {
        
        let data: [DataPoint] = executions.map { execution in
            let timestamp = execution.trainingPlanExecution?.startTimeStamp
            
            // Calculate weighted average of exerciseExecutionSets
            var totalWeightedValue: Float = 0.0
            var totalReps: Int = 0
            
            for set in (execution.exerciseExecutionSets ?? []) {
                totalWeightedValue += set.weight * Float(set.reps)
                totalReps += Int(set.reps)
            }
            
            let averageWeight = totalWeightedValue / Float(totalReps)
            
            return DataPoint(timestamp: Date(timeIntervalSince1970: TimeInterval(timestamp!)), weight: averageWeight)
        }.sorted { $0.timestamp < $1.timestamp }
        
        VStack {
            Chart(data) { point in
                LineMark(
                    x: .value("Date", point.timestamp),
                    y: .value("Weight", point.weight)
                )
                .foregroundStyle(.blue)
            }
            .frame(height: 300)
            .padding()
            .chartXAxis {
                AxisMarks(format: .dateTime.weekday(.abbreviated))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .onAppear {
            // Print data content when the view appears
            print("Data Points:")
            for point in data {
                print("Timestamp: \(point.timestamp), Weight: \(point.weight)")
            }
        }
    }
}
