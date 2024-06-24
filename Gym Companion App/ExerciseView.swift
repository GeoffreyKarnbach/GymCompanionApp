//
//  ExerciseView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 23.06.24.
//

import SwiftUI
import SwiftData

struct ExerciseView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isShowingExerciseEditScreen: Bool = false

    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.fullName)
            Text(exercise.name)
            Text(exercise.category?.name ?? "TEST")

            Spacer()
        }
        .toolbar {
            if !exercise.isDefault {
                // TODO: ADD DELETE BUTTON
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingExerciseEditScreen = true
                    }) {
                        Image(systemName: "pencil.circle")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingExerciseEditScreen) { EditCustomExercise(exercise: exercise) }

    }
    
}

struct EditCustomExercise: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Bindable var exercise: Exercise
    @State var categoryName: String = "Arme"
    
    @Query private var categories: [ExerciseCategory]
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Kurzer Name", text: $exercise.name)
                TextField("Langer Name", text: $exercise.fullName)
                Picker("Kategorie", selection: $categoryName) {
                    ForEach(categories.sorted(by: { $0.name < $1.name }), id: \.self) {
                        Text($0.name).tag($0.name)
                    }
                }
            }
            .navigationTitle("Neue Übung")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Speichern") {
                        
                        let selectedCategory = categories.first(where: {$0.name == categoryName})
                        
                        self.exercise.category = selectedCategory
                        
                        dismiss()
                    }
                }
            }
            
        }
        .onAppear {
            self.categoryName = self.exercise.category?.name ?? "Arme"
        }
        
    }
}
