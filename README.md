<div align="center">
  <img src="Scale Library/Other/Assets.xcassets/AppIcon.appiconset/mac128.png" alt="Logo" width="80" height="80">

  <h1 align="center">Scale Library</h1>

  <p align="center">
    An awesome tracker for your scale modeling journey!
  </p>
</div>

## About The Project
<div align="center">
  <img src="Images/AppDemo.gif">
</div>

<br><br><br>

### Overview
Scale Library is an IOS application for scale model enthusiasts to easily manage their model kit collection, keep track of accessories and paints, and plan future projects with a streamlined and intuitive interface.

### Personal objectives
As the first native IOS application that I have built from scratch, here are the main learning objectives that I had given myself for this project.
1. Learn SwiftUI Fundamentals
    - Understand the basic structure of SwiftUI.
    - Familiarise myself with SwiftUI views and modifiers.
    - Understand data flows between views.
    - Data binding and state management.

2. Learn and incorporate the brand new SwiftData
    - Creating SwiftData models and integrating it with SwiftUI.
    - Swift-native predicates.
    - Performing complex operations using ModelContext API directly.

2. Experiment with MVVM in SwiftUI and SwiftData
    - Understand the principles of MVVM architecture.
    - Implement MVVM structure in the project(For better or worse).
    - Comparison between pure SwiftUI + SwiftData and SwiftUI + SwiftData + MVVM.

## Features
This section covers the features that I have implemented so far, as well as the future plans for each of them.

### Home screen:
- Features:
  - Access to other pages.
  - Provides an overview of your stash such as total number for each category as well as the amount spent.
- Limitations:
  - Only model kits page is accessible.
  - Only overview for model kits is available.
- Future plans:
  - Fix limitations.
  - Display some statistics on spendings and number of purchased items using graphs.

<div align="center">
  <img src="Images/HomeView.png" width="30%">
</div>

### Model kits page:
- Features:
  - Displays all the model kits and basic info sorted alphabetically by title.
  - Gridviw is able to make full use of the available screen area by displaying more or less model kits depending on orientation and device(iPhone & iPad).
  - Tapping on a model kit brings you to its detailed page.
  - Activating context menu for a model kit allows quick access to editing and deleting of the model kit.
  - Add button on the toolbar opens a form to add new model kits.
- Limitations:
  - No search, sorting and filtering available.
  - Context menu borders does not conform to model kit card properly.
  - Delete button's text in the context menu is not red.
  - Animation when deleting a model kit is wonky.
- Future plans:
  - Fix limitations.
  - Provide list view as an option alongside griview.

<div align="center">
  <img src="Images/ModelKitsView.gif">
</div>

### Model kit detailed page:
- Features:
  - Displays all the information about the model kit.
  - Display the project that the model kit was planned for.
  - Menu item allows quick access to editing and deleting of the model kit.
- Limitations:
  - Unable to view image in fullscreen.
  - Long portrait images causes strange animation behaviour during opening and closing of page.
  - Some information like scale, brand, category and planned project are currently static.
- Future plans:
  - Fix limitations.

<div align="center">
  <img src="Images/ModelKitsViewContextMenu.png" width="30%">
</div>
