//
//  ExerciseListView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData

struct ExerciseSection: Hashable {
    var title: String
    var exercises: [String]
}

struct ExerciseListView: View {
    @Environment(\.modelContext) private var context

    var exerciseSections: [ExerciseSection]
    @Query var categories: [ExerciseCategory]
    @Query var exercises: [Exercise]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exerciseSections, id: \.self) { section in
                    ExerciseSectionView(sectionTitle: section.title, exercises: section.exercises)
                }
            }
            .navigationBarTitle("Geräte", displayMode: .inline)
        }
        .onAppear {
            printAll()
        }
    }
    
    private func printAll() {
        for exercise in exercises {
            print(exercise.name)
        }
    }
    
    
}

#Preview {
    ExerciseListView(exerciseSections: [
        ExerciseSection(title: "Arme", exercises: ["Arme 1A", "Arme 2A"]),
        ExerciseSection(title: "Bank", exercises: ["Bank 1A", "Bank 2A"]),
        ExerciseSection(title: "Bauch", exercises: ["Bauch 1A", "Bauch 2A"]),
        ExerciseSection(title: "Beine", exercises: ["Beine 1A"]),
        ExerciseSection(title: "Brust", exercises: ["Brust 1A", "Brust 2A", "Brust 3A"])
    ])
}


