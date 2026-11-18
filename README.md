# Planto 🌱

Planto is an iOS app designed to make taking care of plants easier and more organized. It allows users to add their plants, manage their information, and receive watering reminders to help them keep track of their plant care.

## What You Can Do

- Add plants with their name, room, light condition, watering frequency, and water amount.
- Receive notifications when it's time to water.
- Mark plants as watered and track daily progress.
- Edit or delete plants whenever needed.
- Save plant data locally so it remains available when reopening the app.

## How It's Built

Planto follows the **MVVM (Model-View-ViewModel)** architecture to keep the code organized and separate the UI from the app's logic.

- **Model:** `Plant` stores the information for each plant.
- **Views:** SwiftUI screens that display the interface and handle user interactions.
- **ViewModels:** `PlantsViewModel` and `SetReminderViewModel` manage state and application logic.
- **Services:** `NotificationManager` handles scheduling and cancelling local notifications.

## Project Structure

```text
Planto/
├── MyApp.swift
├── Models/
│   └── Plant.swift
├── Services/
│   └── NotificationManager.swift
├── Theme/
│   └── Colors.swift
├── view/
│   ├── AllDoneView
│   ├── MyPlantsEmptyView
│   ├── NoRemindersView
│   ├── PlantsListView
│   ├── PlantsRootView
│   ├── SetReminderView
│   └── SharedComponents
└── viewModel/
    ├── PlantsViewModel
    └── SetReminderViewModel
```

## Technologies & Tools

- **Swift** – Programming language.
- **SwiftUI** – User interface development.
- **Combine** – Observable state management and UI updates.
- **UserNotifications** – Local watering notifications.
- **UserDefaults** – Local plant data storage.
- **Sketch** – UI design.
- **Icon Composer** – App icon creation.
- **Xcode** – Development and testing.

## Try It

1. Open the project in Xcode.
2. Select an iPhone simulator.
3. Press **Run (⌘R)** and allow notifications when prompted.

---



