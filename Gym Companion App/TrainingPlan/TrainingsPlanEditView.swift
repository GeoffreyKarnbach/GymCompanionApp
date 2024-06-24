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
    
    var body: some View {
        VStack {
            List {
                ForEach(trainingsplan.exerciseInTraining!.sorted(by: {
                    $0.order < $1.order
                }), id: \.self) { exercise in
                    TrainingsPlanSingleExerciseView(exercise: exercise)
                }
                Button("+ Neue Übung") {
                    isShowingNewExerciseScreen = true
                }
            }
        }
        .navigationTitle(trainingsplan.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingNewExerciseScreen) { AddExerciseToPlan() }

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
    
    @State var categoryName: String = ""
    @State var selectedExerciseName: String = ""
    @State private var setCount: Int = 1
    @State private var repCount: Int = 1
    @State private var weight: Float = 10

    
    var alreadyAddedExerciseNames: [String] = []
    
    @Query private var categories: [ExerciseCategory]
    
    @Query private var exercises: [Exercise]

    var body: some View {
        NavigationStack{
            Form {
                Picker("Kategorie", selection: $categoryName) {
                    ForEach(categories.sorted(by: { $0.name < $1.name }), id: \.self) {
                        Text($0.name).tag($0.name)
                    }
                }
                if categoryName != "" {
                    let filteredExercises = self.exercises.filter {
                        $0.category?.name == categoryName &&
                        !alreadyAddedExerciseNames.contains($0.name)
                    }
                                        
                    Picker("Übung", selection: $selectedExerciseName) {
                        ForEach(filteredExercises.sorted(by: { $0.name < $1.name }), id: \.self) {
                            Text($0.name).tag($0.name)
                        }
                    }
                }
                
                if selectedExerciseName != "" {
                    Stepper("Sätze: \(setCount)", value: $setCount, in: 1...10, step: 1)
                    
                    Stepper("Wiederholungen: \(repCount)", value: $repCount, in: 1...50, step: 1)
                    
                    let selectedExercise = exercises.filter { $0.name == selectedExerciseName}.first
                    
                    let minWeightStepper = selectedExercise?.minWeight ?? 0
                    let maxWeightStepper = selectedExercise?.maxWeight ?? 200
                    let weightStepStepper = selectedExercise?.weightStep ?? 2.5
                    
                    
                    Stepper("Gewicht: \(weight.formatted())", value: $weight, in: Float(minWeightStepper)...Float(maxWeightStepper), step: weightStepStepper)

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
                        /**
                        let selectedCategory = categories.first(where: {$0.name == category})
                        
                        let newExercise = Exercise(isDefault: false, explanation: "", fullName: fullname, iconName: "dumbbell", maxWeight: 200, minWeight: 5, name: name, weightStep: 1, category: selectedCategory, executions: [], inTrainings: [])
                        
                        context.insert(newExercise)
                        
                        let jsonEncodableNewExercise = ExerciseJSON(name: name, fullname: fullname, categoryName: category)
                        
                        let _ = JsonEncoders.encodeNewCustomExercise(fileName: "exercisesCustom", exercise: jsonEncodableNewExercise)
                         **/
                        
                        dismiss()
                    }
                }
            }
            
        }
    }
}
