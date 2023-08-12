# CameraTok

CameraTok App

Demo video: [CameraTok](https://drive.google.com/file/d/1D8Xh5Hrdm8y91jfx5W0vu5Q5GvM3lw0q/view?usp=sharing)

## General Project Structure

```
├── CameraTok
│   ├── Core
│   ├── Data
│   ├── Generated
│   ├── Resources
│   └── UI
├── CameraTok.xcodeproj
└── swiftgen.yml
```

### Core
```
├── Coordinators
└── Scenes
```
This module contains all the core functionalities inside the app, such us:
- Navigation (Coordinators)
- Scenes (Views, ViewModels, ViewControllers)

#### Navigation
```
├── AppCoordinator.swift
├── Base
├── IntroCoordinator.swift
└── VideosCoordinator.swift
```

SwiftUI has a very limited way to handle navigation so I decided to use the Coordinator pattern to handle the navigation in the app. So three main coordinators were created:

- AppCoordinator: This is the root coordinator of the app and it is used to handle global navigation with child coordinators and decides to show the intro screens or the home screens depending on the preferences of the app.
- IntroCoordinator: Responsible for handling the navigation of the Intro workflow
- VideosCoordinator: Responsible for handling the navigation of the videos workflow (Gallery and VideoPlayer)

*Notes:*
- In the SceneDelegate some updates were made so the app uses the Coordinator ViewControllers to delegate the navigation.
- Each SwiftUI View has it's hosting ViewController to make the navigation easier to handle and more customizable.

#### Scenes
```
├── Intro
├── VideoGallery
└── VideoPlayer
```

The app UI is built with SwiftUI using the MVVM architecture with the following structure:

- View: SwiftUI view contraining all the UI and presentation logic, it has a reference to an ```@ObservedObject``` which is the ViewModel
- ViewModel: Observable class that handles all the business and data logic, its responsible for fetching and giving the information that the View needs, it is also responsible for managing navigation using the Coordinator instance.


### Data
This module contains all the logic to access and handle the data from the app (online and offline storage).
```
├── CoreData
├── Extensions
├── Managers
├── Models
└── Service
```

### Service
Services responsible for fetching and updating the data. The creation of this service allows the data fetching to be centralized so in the future online API calls can replace the local data fetching and updates so there is no update required on the ViewModels using these services as they only worry about getting certain data models.

### CoreData
In order for the app to store locally the likes and dislikes from the user, CoreData was the best option as it allows to build data entities and store them in a local database that is fast and easy to use.

### Managers
```
├── CoreDataManager+Videos.swift
├── CoreDataManager.swift
├── GalleryManager.swift
└── PreferencesManager.swift
```
Shared classes that serve the purpose of a wrapper above native interfaces to make it easier to use native SDKs and provide pre-defined functions that were responsible for fetching the data.

- CoreDataManager: Responsible for fetching the database of videos
- GalleryManager: Responsible for fetching the videos from the gallery
- PreferencesManager: Responsible for handling the app user's preferences

### Extensions
Useful extensions to translate PHAssets into thumbnail images and video urls that were going to be used by the GalleryView and the VideoPlayer.

### Model
Data abstractions to model entities that were going to be used all over the app.

## UI
```
├── Buttons
├── Styles
└── Views
```
This module contains all the UI components and styles that are going to be reused on the app


## Resource Management

Resouces are managed using ```Swiftgen``` which is a tool that processes the project and generates in-code interfaces to use Localizable Strings, Images and Colors.

### Resources
```
├── Assets.xcassets
└── Localizable.strings
```

### Generated
```
├── Assets.swift
└── Strings.swift
```
