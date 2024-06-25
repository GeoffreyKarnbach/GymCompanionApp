//
//  TrainingsPlanSingleExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct TrainingsPlanSingleExerciseView: View {
    var exercise: ExerciseInTraining
    
    var body: some View {
        GroupBox(label: Text(exercise.exercise?.category?.name ?? "TEST CATEGORY")) {
            HStack {
                Label(exercise.exercise?.name ?? "TEST NAME", systemImage: "dumbbell.fill")
                Spacer()
            }
            .padding(.top, 10)
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
