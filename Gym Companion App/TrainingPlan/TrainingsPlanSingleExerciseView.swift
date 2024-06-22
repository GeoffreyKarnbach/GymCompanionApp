//
//  TrainingsPlanSingleExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct TrainingsPlanSingleExerciseView: View {
    //var exercise: Exercise = null
    var body: some View {
        GroupBox(label: Text("CATEGORY")) {
            HStack {
                Label("NAME", systemImage: "dumbbell.fill")
                Spacer()
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    TrainingsPlanSingleExerciseView()
}
