//
//  ExerciseSectionView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct ExerciseSectionView: View {
    
    var sectionTitle: String = ""
    var exercises: [Exercise] = []

    var body: some View {
        Section(header: Text(sectionTitle))
        {
            ForEach(exercises, id: \.self) {
                exercise in
                ExerciseItemView(exerciseName: exercise.name)
            }
        }
    }
}

#Preview {
    ExerciseSectionView()
}
