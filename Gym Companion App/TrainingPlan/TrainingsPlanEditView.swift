//
//  TrainingsPlanEditView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI
import SwiftData

struct TrainingsPlanEditView: View {
    @Environment(\.modelContext) private var context
    @State private var isShowingNewExerciseScreen: Bool = false
    
    var trainingsplan: TrainingPlan
    
    var exerciseNames: [String] {
        if let exercises = trainingsplan.exerciseInTraining {
            return exercises.compactMap { $0.exercise?.name }
        }
        return []
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(trainingsplan.exerciseInTraining!.sorted(by: {
                    $0.order < $1.order
                }), id: \.self) { exercise in
                    TrainingsPlanSingleExerciseView(exercise: exercise)
                    .swipeActions {
                        Button("Löschen", role: .destructive) {
                            context.delete(exercise)
                        }
                        .tint(.red)
                    }
                }
                Button("+ Neue Übung") {
                    isShowingNewExerciseScreen = true
                }
            }
        }
        .navigationTitle(trainingsplan.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingNewExerciseScreen) { AddExerciseToPlan(currentOrderPosition: Int32(trainingsplan.exerciseInTraining!.count + 1), currentTrainingsplan: trainingsplan, alreadyAddedExerciseNames: exerciseNames)
        }
        

    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlan>(predicate: #Predicate { $0.name.contains("1")})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        TrainingsPlanEditView(trainingsplan: tp1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
    }

}

struct AddExerciseToPlan: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var currentOrderPosition: Int32
    var currentTrainingsplan: TrainingPlan
    
    @State var categoryName: String = ""
    @State var selectedExerciseName: String = ""
    @State private var setCount: Int32 = 1
    @State private var repCount: Int32 = 1
    @State private var weight: Float = 10

    
    var alreadyAddedExerciseNames: [String]
    
    @Query private var categories: [ExerciseCategory]
    
    @Query private var exercises: [Exercise]

    var body: some View {
        NavigationStack{
            Form {
                Picker("Kategorie", selection: $categoryName) {
                    Text("").tag("")
                    ForEach(categories.sorted(by: { $0.name < $1.name }), id: \.self) {
                        Text($0.name).tag($0.name)
                    }
                }
                if categoryName != "" {
                    let filteredExercises = self.exercises.filter {
                        $0.category?.name == categoryName &&
                        !alreadyAddedExerciseNames.contains($0.name)
                    }
                    
                    if filteredExercises.count > 0 {
                        Picker("Übung", selection: $selectedExerciseName) {
                            Text("").tag("")
                            ForEach(filteredExercises.sorted(by: { $0.name < $1.name }), id: \.self) {
                                Text($0.name).tag($0.name)
                            }
                        }
                    } else {
                        Text("Keine Übungen mehr in der Kategorie")
                    }
                                        
 
                }
                
                if selectedExerciseName != "" {
                    Stepper("Sätze: \(setCount)", value: $setCount, in: 1...10, step: 1)
                    
                    Stepper("Wiederholungen: \(repCount)", value: $repCount, in: 1...50, step: 1)
                    
                    let selectedExercise = exercises.filter { $0.name == selectedExerciseName}.first
                    
                    let minWeightStepper = selectedExercise?.minWeight ?? 0
                    let maxWeightStepper = selectedExercise?.maxWeight ?? 200
                    let weightStepStepper = selectedExercise?.weightStep ?? 2.5
                    
                    HStack {
                        LabeledContent {
                            var formatter: NumberFormatter {
                                let formatterIntern = NumberFormatter()
                                formatterIntern.numberStyle = .decimal
                                return formatterIntern
                            }
                            
                            TextField("Gewicht:", value: $weight, formatter: formatter, onCommit: {
                                weight = round(weight / 2.5) * 2.5
                            })
                                .keyboardType(.decimalPad)
                                .frame(minWidth: 15, maxWidth: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } label: {
                            Text("Gewicht:")
                        }

                        Stepper("Gewicht:", value: $weight, in: Float(minWeightStepper)...Float(maxWeightStepper), step: weightStepStepper)
                            .labelsHidden()
                            .onAppear {
                                weight = Float(selectedExercise?.minWeight ?? 0)
                            }
                    }
                    
                    
                }
            }
            .navigationTitle("Hinzufügen")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Speichern") {
                        
                        if selectedExerciseName == "" {
                            return
                        }
                                                
                        let selectedExercise = exercises.first(where: {$0.name == selectedExerciseName})
                        
                        let newExerciseInTraining = ExerciseInTraining(order: currentOrderPosition, repCount: repCount, setCount: setCount, weight: weight, exercise: selectedExercise, exerciseExecution: [], trainingPlan: nil)
                        
                        context.insert(newExerciseInTraining)
                                                
                        currentTrainingsplan.exerciseInTraining?.append(newExerciseInTraining)
                        
                        
                        dismiss()
                    }
                }
            }
            
        }
    }
}
