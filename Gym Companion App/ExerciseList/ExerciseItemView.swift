//
//  ExerciseItemView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct ExerciseItemView: View {
    var exercise: Exercise
    
    var body: some View {
        NavigationLink(destination: ExerciseView(exercise: exercise)) {
            HStack
            {
                Image(systemName: "dumbbell.fill")
                    .scaledToFit()
                Text(exercise.name)
                    .padding(.leading, 8)
            }
        }
    }
}
