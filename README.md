# coolstore

## Folder Structure

```
lib/
├── main.dart                    # Entry point of the application
├── app/
│   ├── app.dart                 # App Widget & MaterialApp 
│   ├── router.dart              # Route management
│   └── di/                      # Dependency Injection 
├── config/
│   ├── theme/                   # Theme and styles 
│   └── constants/               # App-wide constants
├── core/                        # Core module for common 
│   ├── error/                   # Error handling
│   ├── network/                 # Network information checker
├── data/                        # Data layer 
│   ├── models/                  # Data models
│   ├── repositories/            # Concrete implementations of repositories
│   └── datasources/             # Remote and Local data sources (API, Local DB)
├── domain/                      # Domain layer (Business Logic)
│   ├── entities/                # Pure Dart classes (Product, User, etc.)
│   ├── repositories/            # Abstract repositories
│   └── usecases/                # Business rules (GetProducts, LoginUser, etc.)
├── presentation/                # UI layer
│   ├── blocs/                   # Bloc files (ProductBloc, AuthBloc, etc.)
│   ├── cubits/                  # Cubit files (if using Cubit for simpler state management)
│   ├── screens/                 # UI Screens (HomeScreen, ProductDetailsScreen, LoginScreen, etc.)
│   ├── widgets/                 # Reusable UI components
│   └── routes/                  # Screen navigation management
├── utils/                       # General utility functions
└── main.dart                    # App entry point
```


