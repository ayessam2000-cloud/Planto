import SwiftUI

struct PlantsRootView: View {
    @StateObject private var viewModel = PlantsViewModel()

    var body: some View {
        Group {
            if !viewModel.started {
                MyPlantsEmptyView(onSetReminder: { viewModel.sheet = .add })
            } else if viewModel.plants.isEmpty {
                NoRemindersView(onAdd: { viewModel.sheet = .add })
            } else if viewModel.allDone {
                AllDoneView(onAdd: { viewModel.sheet = .add })
            } else {
                PlantsListView(
                    plants: viewModel.sortedPlants,
                    doneCount: viewModel.doneCount,
                    progress: viewModel.progress,
                    onToggle: viewModel.toggle,
                    onDelete: viewModel.delete,
                    onEdit: { viewModel.sheet = .edit($0) },
                    onAdd: { viewModel.sheet = .add }
                )
            }
        }
        .sheet(item: $viewModel.sheet, onDismiss: { viewModel.started = true }) { item in
            switch item {
            case .add:
                SetReminderView(onSave: viewModel.add)
            case .edit(let plant):
                SetReminderView(plant: plant,
                                onSave: viewModel.update,
                                onDelete: { viewModel.delete(plant) })
            }
        }
    }
}
