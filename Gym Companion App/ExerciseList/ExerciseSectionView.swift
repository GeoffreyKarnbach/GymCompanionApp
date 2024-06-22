//
//  ExerciseSectionView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 19.06.24.
//

import SwiftUI

struct ExerciseSectionView: View {
    
    var sectionTitle: String
    var exercises: [String]

    var body: some View {
        Section(header: Text(sectionTitle))
        {
            ForEach(exercises, id: \.self) {
                exercise in
                ExerciseItemView(exerciseName: exercise)
            }
        }
    }
}

#Preview {
    ExerciseSectionView(sectionTitle: "Arme", exercises: ["Arme 1A", "Arme 2A"])
}
