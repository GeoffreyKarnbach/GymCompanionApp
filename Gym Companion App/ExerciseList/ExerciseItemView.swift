//
//  ExerciseItemView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct ExerciseItemView: View {
    var exerciseName: String
    
    var body: some View {
        HStack
        {
            Image(systemName: "dumbbell.fill")
                .scaledToFit()
            Text(exerciseName)
                .padding(.leading, 8)
        }
    }
}

#Preview {
    ExerciseItemView(exerciseName: "Arme 1A")
}
