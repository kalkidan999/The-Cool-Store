# Cool Store

This is a eCommerce application built using **Flutter** following the **Clean Architecture** pattern with state management handled by **Bloc**, dependency injection using **GetIt**, and integrating the API from [FakeStoreAPI](https://fakestoreapi.com/).

## Features
- Browse products by categories.
- View product details.
- Add products to cart.
- Remove products from cart.
- Checkout process.
- API integration with FakeStoreAPI.

## Architecture
The application follows **Clean Architecture**, which ensures separation of concerns and makes the codebase maintainable and testable. The layers are:
- **Presentation Layer** (UI, Bloc, State Management)
- **Domain Layer** (Entities, Repositories, Use Cases)
- **Data Layer** (API Integration, Models, Repository Implementations)

## Packages Used
- **flutter_bloc** - For state management.
- **get_it** - For dependency injection.
- **dio** - For making network requests.
- **equatable** - For value comparison in Bloc states and events.

## Getting Started
### Prerequisites
Ensure you have Flutter installed. To check, run:
```bash
flutter --version
```

### Installation
1. Clone the repository:
```bash
git clone https://github.com/kalkidan999/The-Cool-Store
```
2. Navigate to the project directory:
```bash
cd The-Cool-Store
```
3. Install dependencies:
```bash
flutter pub get
```
4. Run the app:
```bash
flutter run
```

## Folder Structure
```
lib/
│
├── app             # Application interface (Router, Material App)
├── core/           # Dependency Injection (GetIt setup), Network configuration, Error handling)
├── data/           # Data layer - Models, Repositories (API integration)
├── domain/         # Domain layer - Entities, Use Cases, Repository contracts
├── presentation/   # Presentation layer - UI, Blocs, States, Events
├── utils/          # App-wide utilities
```

## API Integration
The app fetches product data from [FakeStoreAPI](https://fakestoreapi.com/), which provides fake data for user authentication, products, categories, and product details.

### Example API Request
```dart
final response = await dio.get('https://fakestoreapi.com/products');
```

## Dependency Injection
`GetIt` is used for dependency injection, making sure all instances of Blocs, UseCases, and Repositories are properly managed and accessible throughout the app.

## State Management
`Bloc and Cubit` 

Cubit: A simpler way to manage state with minimal boilerplate. Used where only state change is needed without handling events.

Bloc: A more powerful state management solution that works with events and state, providing better scalability for complex scenarios.

Blocs and Cubits are registered using GetIt for dependency injection to keep the presentation layer clean and organized.



## Testing
Unit and widget tests are implemented using `flutter_test` and `bloc_test` packages.

### Run Tests
```bash
flutter test
```

## Future Improvements
- Adding Product Search functionality.
- Improving UI and adding animations.

