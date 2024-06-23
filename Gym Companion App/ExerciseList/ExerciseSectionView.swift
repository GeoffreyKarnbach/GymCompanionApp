//
//  ExerciseSectionView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct ExerciseSectionView: View {
    
    var sectionTitle: String = ""
    var showOnlyCustomExercises: Bool = false
    var exercises: [Exercise] = []

    var body: some View {
        Section(header: Text(sectionTitle))
        {
            ForEach(filteredExercises, id: \.self) {
                exercise in
                ExerciseItemView(exercise: exercise)
            }
        }
    }
    
    private var filteredExercises: [Exercise] {
        return exercises
            .filter { $0.isDefault != showOnlyCustomExercises } // Filter exercises based on showOnlyCustomExercises
            .sorted(by: { $0.name < $1.name }) // Always sort exercises alphabetically by name
    }
}

#Preview {
    ExerciseSectionView()
}
