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
    @Environment(\.modelContext) private var context

    @State private var isShowingExerciseEditScreen: Bool = false

    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.fullName)
                .font(.title)
                .fontWeight(.bold)
                .underline()
                .padding(.vertical, 15)
            Text(exercise.name)
            Text(exercise.category?.name ?? "TEST")
            Divider()
            if (exercise.inTrainings?.count ?? 0) > 0 {
                Text("Übung in Trainingsplänen:")
                    .fontWeight(.bold)
                    .underline()
                    .padding(.vertical, 15)
                VStack {
                    ForEach((exercise.inTrainings?.sorted{($0.trainingPlan?.name ?? "") < ($1.trainingPlan?.name ?? "")})!, id: \.self) { execInTp in
                        if let tp = execInTp.trainingPlan {
                            NavigationLink(destination: TrainingsPlanDetailView(trainingsplan: tp)) {
                                HStack {
                                    Spacer()
                                    Text(execInTp.trainingPlan?.name ?? "DEFAULT TRAININGSPLAN NAME")
                                    Spacer()
                                }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                }
            }
            if (exercise.executions?.count ?? 0) > 0 {
                Spacer()
                Divider()
                Text("Ausführungen:")
                    .fontWeight(.bold)
                    .underline()
                    .padding(.vertical, 15)
                ForEach(exercise.executions ?? [], id: \.self) { execution in
                    Text(execution.exercise?.fullName ?? "NAME")
                }
            }
            Spacer()

        }
        .toolbar {
            if !exercise.isDefault {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingExerciseEditScreen = true
                    }) {
                        Image(systemName: "pencil.circle")
                    }
                    Button(action: {
                        context.delete(exercise)
                    }) {
                        Image(systemName: "trash")
                            .tint(.red)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingExerciseEditScreen) { EditCustomExercise(exercise: exercise) }
        .padding(.leading, 15)
        .navigationBarTitleDisplayMode(.inline)

    }
    
}

#Preview {
    ZStack {
        var descriptor = FetchDescriptor<Exercise>(predicate: #Predicate { $0.name.contains("3")})
        
        let exec1 = try! PreviewContainerGenerator.previewContainer.mainContext.fetch(
            descriptor
        )
        
        ExerciseView(exercise: exec1.first!)
            .modelContainer(PreviewContainerGenerator.previewContainer)
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
