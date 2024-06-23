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
    @State private var isShowingNewExercise: Bool = false

    @Query var categories: [ExerciseCategory]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories.sorted(by: { $0.name < $1.name }), id: \.self) { category in
                    ExerciseSectionView(sectionTitle: category.name, exercises: category.exercises)
                }
            }
            .navigationTitle("Übungen")
            .sheet(isPresented: $isShowingNewExercise) { AddCustomExercise() }
            .toolbar {
                Button(action: {
                    isShowingNewExercise = true
                })
                {
                    HStack {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

struct AddCustomExercise: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var fullname: String = ""
    @State private var category: String = "Arme"
    
    @Query private var categories: [ExerciseCategory]

    var body: some View {
        NavigationStack{
            Form {
                TextField("Kurzer Name", text: $name)
                TextField("Langer Name", text: $fullname)
                Picker("Kategorie", selection: $category) {
                    ForEach(categories, id: \.self) {
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
                        
                        let selectedCategory = categories.first(where: {$0.name == category})
                        
                        let newExercise = Exercise(isDefault: false, explanation: "", fullName: fullname, iconName: "dumbbell", maxWeight: 200, minWeight: 5, name: name, weightStep: 1, category: selectedCategory, executions: [], inTrainings: [])
                        
                        context.insert(newExercise)
                        
                        let jsonEncodableNewExercise = ExerciseJSON(name: name, fullname: fullname, categoryName: category)
                        
                        let _ = JsonEncoders.encodeNewCustomExercise(fileName: "exercisesCustom", exercise: jsonEncodableNewExercise)
                        
                        dismiss()
                    }
                }
            }
            
        }
    }
}
    


#Preview {
    ExerciseListView()
}


