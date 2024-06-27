//
//  TrainingsPlanSingleExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct TrainingsPlanSingleExerciseView: View {
    var exercise: ExerciseInTraining
    
    var isCompactMode: Bool = false
    var isActiveTrainingView: Bool = false
    var exerciseCompleted: Bool = false
    
    var body: some View {
        GroupBox(label: Label(exercise.exercise?.name ?? "TEST NAME", systemImage: "dumbbell.fill")) {
            if !isCompactMode {
                HStack {
                    Text(exercise.exercise?.category?.name ?? "TEST CATEGORY")
                    Spacer()
                    if isActiveTrainingView {
                        Image(systemName: exerciseCompleted ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(exerciseCompleted ? .green : .red)
                    }
                }
                .padding(.top, 10)
            
                if !isActiveTrainingView {
                    Divider()
                    HStack {
                        Label("Sets: " + exercise.setCount.description, systemImage: "arrow.counterclockwise.circle")
                        Spacer()
                    }
                    .padding(.top, 10)
                    HStack {
                        Label("Reps: " + exercise.repCount.description, systemImage: "arrow.counterclockwise.circle.fill")
                        Spacer()
                    }
                    .padding(.top, 10)
                    HStack {
                        Label("Gewicht: " + exercise.weight.description + " kg", systemImage: "scalemass")
                        Spacer()
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
}
