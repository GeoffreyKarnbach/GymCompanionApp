//
//  TrainingsPlanView.swift
//  Gym Companion App
//
//  Created by Geoffrey Karnbach on 18.06.24.
//

import SwiftUI
import SwiftData

struct TrainingsPlanView: View {
    @Environment(\.modelContext) private var context
    
    @State private var isShowingNewPlan: Bool = false
    @State private var isShowingEditPlan: Bool = false
    @State private var trainingsPlanToEdit: TrainingPlan?

    @Query() var trainingsplans: [TrainingPlan]

    var body: some View {
        NavigationStack {
            List {
                ForEach(trainingsplans) {
                    trainingplan in
                    TraingsPlanCell(trainingplan: trainingplan)
                    
                        .swipeActions {
                            Button("Löschen", role: .destructive) {
                                context.delete(trainingplan)
                            }
                            .tint(.red)
                            
                            Button("Bearbeiten") {
                                trainingsPlanToEdit = trainingplan
                            }
                            .tint(.blue)
                            
                        }
                }

            }
            .sheet(isPresented: $isShowingNewPlan) { AddTraingsPlan() }
            .sheet(item: $trainingsPlanToEdit) { plan in
                EditTraingsPlan(trainingplan: plan)
            }
            .toolbar {
                if !trainingsplans.isEmpty {
                    Button(action: {
                        isShowingNewPlan = true
                    })
                    {
                        HStack {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
            .navigationTitle("Trainingspläne")
            .overlay {
                if trainingsplans.isEmpty
                {
                    ContentUnavailableView(label: {
                        Label("Kein Trainingsplan", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Füge deinen ersten Trainingsplan hinzu!")
                    }, actions: {
                        Button("Neuer trainingsplan") {
                            isShowingNewPlan = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
    
}

struct TraingsPlanCell: View {
    var trainingplan: TrainingPlan
    
    var body: some View {
        NavigationLink(destination: TrainingsPlanEditView(trainingsplan: trainingplan)){
            GroupBox(label: Label(trainingplan.name , systemImage: "dumbbell")) {
                HStack {
                    Text(trainingplan.days)
                        .padding(.top)
                        .frame(alignment: .topLeading)
                    Spacer()
                }
            }
        }
    }
}

struct AddTraingsPlan: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State var name: String = ""
    @State var days: String = ""
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Name", text: $name)
                TextField("Trainingstage", text: $days)
            }
            .navigationTitle("Neuer Trainingsplan")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Abbrechen") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Speichern") {
                        let trainingsplan = TrainingPlan(days: days, name: name, exerciseInTraining: [])
                        context.insert(trainingsplan)
                        
                        dismiss()
                    }
                }
            }
            
        }
    }
}

struct EditTraingsPlan: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var trainingplan: TrainingPlan
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Name", text: $trainingplan.name)
                TextField("Trainingstage", text: $trainingplan.days)
            }
            .navigationTitle("Trainingsplan bearbeiten")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Speichern") { dismiss() }
                }
            }
            
        }
    }
}

#Preview {
    TrainingsPlanView()
        .modelContainer(PreviewContainerGenerator.previewContainer)

}
