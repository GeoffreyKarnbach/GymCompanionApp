//
//  TrainingPlanSingleActiveExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 27.06.24.
//

import SwiftUI
import SwiftData

struct TrainingPlanSingleActiveExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var currentTrainingsPlan: TrainingPlanExecution
    var currentExerciseInTraining: ExerciseInTraining
    
    var currentExerciseExecution: ExerciseExecution = ExerciseExecution(executionScore: nil, exhaustScore: nil, exercise: nil, exerciseExecutionSets: [], exerciseInTraining: nil)
    
    @State var currentExerciseExecutionSets: [ExerciseSet] = []
    @State private var exhaustScore = 1
    @State private var executionScore = 1
    
    var body: some View {
        NavigationStack {
            
            
            VStack(alignment: .leading) {
                Text(currentExerciseInTraining.exercise?.fullName  ?? "Default Übung")
                    .fontWeight(.bold)
                    .underline()
                    .padding(.vertical, 15)
                    .padding(.leading, 15)
                Text(currentExerciseInTraining.exercise?.category?.name ?? "Default Kategorie")
                    .padding(.leading, 15)
                Divider()
                Spacer()
                
                /**
                 List {
                     ForEach($currentExerciseExecutionSets, id: \.self) { $set in
                         SingleExerciseExecutionSetView(currentSet: $set)
                             .padding(.vertical, 10)
                     }
                 }
                 */
                
                ScrollViewReader { proxy in
                    List {
                        ForEach($currentExerciseExecutionSets, id: \.self) { $set in
                            SingleExerciseExecutionSetView(currentSet: $set)
                                .padding(.vertical, 10)
                                .id(set.orderNumber)
                        }
                    }
                    .onChange(of: currentExerciseExecutionSets.count) { _ in
                        if let lastSet = currentExerciseExecutionSets.last {
                            proxy.scrollTo(lastSet.orderNumber, anchor: .bottom)
                        }
                    }
                }
                
                if currentExerciseExecutionSets.count < currentExerciseInTraining.setCount {
                    HStack {
                        Spacer()
                        Button("Neues Set"){
                            currentExerciseExecutionSets.append(ExerciseSet(set: ExerciseExecutionSet(reps: currentExerciseInTraining.repCount, weight: currentExerciseInTraining.weight, exerciseExecution: nil), isViewingMode: false, isCompleted: false, orderNumber: (currentExerciseExecutionSets.count + 1), planedWeight: currentExerciseInTraining.weight, planedReps: currentExerciseInTraining.repCount))
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        Spacer()
                    }
                    
                } else {
                    Spacer()
                    
                    HStack {
                        Text("Ausführung:")
                            .padding(.leading, 10)
                        Picker("Ausführung:", selection: $executionScore) {
                            ForEach(1..<6) {
                                Text("\($0)").tag($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    HStack {
                        Text("Erschöpfung:")
                            .padding(.leading, 10)
                        Picker("Erschöpfung:", selection: $exhaustScore) {
                            ForEach(1..<6) {
                                Text("\($0)").tag($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    HStack {
                        Spacer()
                        Button("Übung Übersicht") {
                            currentExerciseExecution.exhaustScore = Int32(exhaustScore)
                            currentExerciseExecution.executionScore = Int32(executionScore)
                            
                            var executions : [ExerciseExecutionSet] = []
                            
                            for exec_ in currentExerciseExecutionSets {
                                var temp = exec_.set
                                executions.append(temp)
                            }
                            
                            currentExerciseExecution.exerciseExecutionSets = executions
                            
                            currentExerciseExecution.trainingPlanExecution = currentTrainingsPlan
                            
                            currentExerciseExecution.exercise = currentExerciseInTraining.exercise
                            
                            currentExerciseExecution.exerciseInTraining = currentExerciseInTraining
                            
                            context.insert(currentExerciseExecution)
                            
                            currentExerciseInTraining.exercise?.executions?.append(currentExerciseExecution)
                            
                            dismiss()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        Spacer()
                        
                        /**
                         Button("Nächste Übung") {
                         
                         }
                         .padding()
                         .background(Color.blue)
                         .foregroundColor(.white)
                         .cornerRadius(8)
                         .padding(.top, 20)
                         .padding(.bottom, 10)
                         **/
                    }
                    
                }
                
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}


struct SingleExerciseExecutionSetView: View {
    @Binding var currentSet : ExerciseSet
    @State var setAsPlanned = true

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Set \(currentSet.orderNumber):")
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Geplantes Gewicht: \(currentSet.planedWeight, specifier: "%.0f") kg")
                    Text("Geplante Reps: \(currentSet.planedReps)")
                }
                .padding(.horizontal)
                Spacer()
                VStack {
                    Button(action: {
                        setAsPlanned = true
                    }) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .opacity(setAsPlanned ? 1.0 : 0.3)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Spacer()
                    Button(action: {
                        setAsPlanned = false
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                            .opacity(setAsPlanned ? 0.3 : 1.0)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.vertical, 15)
            }
            .padding(.bottom, 20)
            
            if !setAsPlanned {
                Divider()
                VStack {
                    Stepper("Rep Count:     \(currentSet.set.reps)", value: $currentSet.set.reps, in: 1...50, step: 1)
                    /**
                    HStack {
                        LabeledContent {
                            var formatter: NumberFormatter {
                                let formatterIntern = NumberFormatter()
                                formatterIntern.numberStyle = .decimal
                                return formatterIntern
                            }
                            
                            TextField("Gewicht:", value: $currentSet.set.weight, formatter: formatter, onCommit: {
                                currentSet.set.weight = round(currentSet.set.weight / 2.5) * 2.5
                            })
                            .keyboardType(.decimalPad)
                            .frame(minWidth: 15, maxWidth: 60)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        } label: {
                            Text("Gewicht:")
                        }
                        
                        Stepper("Gewicht:", value: $currentSet.set.weight, in: 1...100, step: 1)
                            .labelsHidden()
                            .onAppear {
                                currentSet.set.weight = currentSet.planedWeight
                            }
                    }
                     **/
                    Stepper("Gewicht:     \(currentSet.set.weight, specifier: "%.0f")", value: $currentSet.set.weight, in: 1...100, step: 1)
                        .onAppear {
                            currentSet.set.weight = currentSet.planedWeight
                        }
                }
                
            }
        }
    }
}

struct ExerciseSet: Hashable {
    var set: ExerciseExecutionSet
    var isViewingMode: Bool
    var isCompleted: Bool
    var orderNumber: Int
    var planedWeight: Float
    var planedReps: Int32
    
    init(set: ExerciseExecutionSet, isViewingMode: Bool, isCompleted: Bool, orderNumber: Int, planedWeight: Float, planedReps: Int32) {
        self.set = set
        self.isViewingMode = isViewingMode
        self.isCompleted = isCompleted
        self.orderNumber = orderNumber
        self.planedWeight = planedWeight
        self.planedReps = planedReps
    }
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<TrainingPlanExecution>(predicate: #Predicate { $0.endTimeStamp == -1})
        
        let tp1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        ).first!
        
        var descriptor2 = FetchDescriptor<ExerciseInTraining>(predicate: #Predicate { $0.order == 1})
        
        let exInTraining = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor2
        ).first!
        
        TrainingPlanSingleActiveExerciseView(
            currentTrainingsPlan: tp1 ,
            currentExerciseInTraining: exInTraining
        )
        .modelContainer(PreviewContainerGenerator.previewContainer)
    }
    
}

