### Movie Discovery App - Final Project  
**Created by:** Hrvoje Buljan (RIT Student)  
**Date:** December 10, 2023  


---

## 📖 Overview  
A Swift-based iOS application designed for movie discovery. The app integrates real-time data from the TMDb API to deliver personalized recommendations, mood-based suggestions, and an intuitive search functionality.  

---

## 🌟 Features  
1. **Movie Listing**: Displays dynamically updated movie data fetched from the TMDb API.  
2. **Personalized Recommendations**: Suggests movies tailored to user preferences and viewing history.  
3. **Mood Selector**: Recommends movies based on the user's current mood.  
4. **Search Functionality**: Enables users to search for movies by title with real-time updates.  
5. **Detailed Movie Information**: Displays:  
   - Title  
   - Poster  
   - Release date  
   - Duration  
   - Genre  
   - Directors  
   - Cast  
   - Ratings (IMDb)  
   - Trailer  

---

## 🚀 Installation Instructions  
1. Clone the repository:  
   ```bash
   git clone https://github.com/username/movie-discovery-app.git
   ```  
2. Open the project in Xcode.  
3. Install dependencies using CocoaPods or Swift Package Manager.  
4. Add your TMDb API key in `Constants.swift`.  
5. Run the project on a simulator or a physical iOS device.  

---

## 🛠️ Technologies Used  
- **Frameworks and Libraries**:  
  - SwiftUI for the user interface.  
  - [ActivityIndicatorView](https://github.com/exyte/ActivityIndicatorView) for loading animations.  
- **APIs**:  
  - TMDb API for fetching real-time movie data.  

---

## 📐 Architecture  
The app follows the **Model-View-ViewModel (MVVM)** architecture for scalability and maintainability.  

### **ViewModel Classes**  
- **`Constants.swift`**: Centralized management of API keys and URLs.  
- **`MovieDetailsViewModel.swift`**: Fetches and processes detailed movie information.  
- **`HomeViewModel.swift`**: Manages data for the home screen.  
- **`MovieSearchViewModel.swift`**: Handles search functionality and updates.  
- **`RecommendationViewModel.swift`**: Generates personalized recommendations.  

### **Model Classes**  
- **`Movie.swift`**: Defines movie properties such as title, genres, and release date.  
- **`Genre.swift`**: Represents movie genres for filtering.  
- **`DiscoverResponse.swift`**: Manages paginated movie data from API calls.  

### **View Classes**  
- **`HomeView.swift`**: Main navigation interface.  
- **`FeaturedMoviesView.swift`**: Carousel for featured movies.  
- **`MovieDetailsView.swift`**: Displays detailed information about a selected movie.  
- **`SearchView.swift`**: Real-time search interface.  
- **`MoodSelectorView.swift`**: Recommends movies based on mood selection.  
- **`WelcomeView.swift`**: Initial setup for user preferences.  

---

## 🎯 Future Improvements  
1. **Dark Mode**: To enhance user comfort and accessibility.  
2. **Advanced Animations**: To create a more engaging user experience.  

---

## 📝 Evaluation  
**Grade:** A  
- Successfully implements MVC architecture.  
- Seamless integration with the TMDb API.  
- Adheres to best practices for clean, maintainable code.  
- Provides a polished UI/UX with animations and interactive features.  

---

## 📊 Alignment with Grading Criteria  
- **Scope**: Meets all project objectives with a focus on dynamic, real-time functionality.  
- **Design Patterns**: Utilizes MVC and delegation effectively.  
- **Code Quality**: Adheres to DRY principles and uses enums for clean coding practices.  
- **UI/UX Design**: Incorporates SwiftUI components such as `NavigationView` and `TabView`.  
![Simulator Screenshot - iPhone 15 Pro - 2025-01-03 at 21 47 35](https://github.com/user-attachments/assets/c4fa8448-ee2d-46f7-970e-f2aca5227a76)

---

## 🏗️ Repository Details  
**Source Code**: The complete codebase is hosted on myCourses.  

---

Feel free to contribute or provide feedback! 😊  
