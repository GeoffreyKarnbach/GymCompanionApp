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
        }
    }
}
