//
//  ExerciseListView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) private var context

    @Query var categories: [ExerciseCategory]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    ExerciseSectionView(sectionTitle: category.name, exercises: category.exercises)
                }
            }
            .navigationBarTitle("Geräte", displayMode: .inline)
        }
    }
    
    
}

#Preview {
    ExerciseListView()
}


