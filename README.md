# firebase_shoe_store

## Configuration:
- Flutter: 3.22.0
- Bloc with Cubit
- Go Router
- Clean Architecture:
    - features
      - data
        - data_sources
        - models
        - repositories
      - domain
        - entities
        - repositories
        - use_cases
      - presentation
        - manager (cubits to manage business logics)
        - pages
        - widgets

## Initial Setup
- Clone the repository from GitLab
- Check if your flutter version is **3.22.0**. If not either upgrade your flutter version using `flutter pub upgrade` or use `fvm` tool to manage multiple version
- If you are using fvm, run `fvm install 3.22.0` and wait for it to finish downloading. If you already have it installed just run the `fvm use 3.22.0`.
    - If you are in **VS Code** then:
        - Tap Command+Shift+P and search for Change SDK. Check if detecting `3.22.0`. If not got to `Preference: Open User Settings (JSON)` and add the following line:
            ```
            "dart.sdkPaths": [".fvm/flutter_sdk", "/Users/dinury/src/flutter/bin/cache/dart-sdk/bin"],

            "dart.flutterSdkPaths": ["/Users/dinury/fvm/versions", "/Users/dinury/src/flutter/bin"],

            // Remove .fvm files from search
            "search.exclude": {
                "**/.fvm": true
            },
            // Remove from file watching
            "files.watcherExclude": {
                "**/.fvm": true
            },
            ```
      Here change the `dart.sdkPaths` & `dart.flutterSdkPaths` with your path.
    - After ensuring correct sdk paths are added tap Command+Shift+P and search for `Flutter: Change SDK` find the appropriate version. In this case `Flutter SDK 3.22.0`. Tap on it.
    - Then tap Command+Shift+P again and search for `Developer: Reload Window`. Tap on it.
    - Then check if VS Code is showing correct SDK version or not by checking  `Flutter: Change SDK`
      It should show: `Flutter SDK 3.22.0 Current Setting`
    - You are good to go. Environment setup is done.
    - For windows and Android Studio, check FVM website
- Run `fvm flutter pub get`
- Everything should be good to go. But if for some reason you are facing issues, try running `fvm flutter clean` and then `fvm flutter pub get` again.

## Running the project
- Run `fvm flutter run` to run the project in your connected device or emulator.
- If you are facing issues with the emulator, try running `fvm flutter run -d all` to run the project in all available devices and emulators.
- If you are facing issues with the emulator, try running `fvm flutter run -d <device_id>` to run the project in a specific device or emulator.
- If you are facing issues with the emulator, try running `fvm flutter devices` to list all available devices and emulators.
- If you are facing issues with the emulator, try running `fvm flutter emulators` to list all available emulators.
- If you are facing issues with the emulator, try running `fvm flutter emulators --launch <emulator_id>` to launch a specific emulator.

## Assumptions made during development
- This e-commerce app is developed for a shoe store, with the assumption that user can only buy shoes.
- User is already logged in as a registered user, who can get all the services within the app.
- The project is also developed with assumption that user will be connected to the Internet while using the app.
- Currently the app has no offline support.

## Features:
- Dashboard: 
  - On dashboard user can see all the available Brands, Initially user will see all the Shoes from all the Brands.
    User can filter the shoes based on Brands. User can see the reviews which are given by other users and is being
    calculated based on the average rating of the reviews (`Using Firebase Functions`).
  - List is paginated, user can see the next page by scrolling to the bottom of the page.
- Product Details:
  - User can see the details of the product, can add the product to the cart, can see the reviews of the product and can give a review.
- Cart:
  - User can see all the products which are added to the cart, can remove the product from the cart, can increase or decrease the quantity of the product.
  - Items added to cart will be stored in the local storage (`Shared Preferences`).
- Order Summary:
  - User can see the summary of the order, can see the total amount of the order, can see the products which are added to the cart.
- Review:
  - User can view reviews of the product, also filter review by stars.
- Order History:
  - User can see the history of the orders which are placed by the user. 
  - User can also give review to the product which is already ordered. (`Firebase functions`)
- Filter:
  - User can filter the products based on the Brands, Price, Gender and Colors.

## Challenges faced during development
- While developing the project, I faced some challenges which are mentioned below:
  - **Firebase Functions**: I faced some issues while deploying the firebase functions, as I was new to firebase functions. But after some research and reading the documentation I was able to deploy the functions.
  - **Filter**: I faced some issues while implementing the filter, as Firebase Datastore is a NoSQL Database, it doesn't support complex queries. I had to add to write a lot of composite indexes to make the filter work.

## Additional Features & Improvements Added (Bonus)
- **Pagination**: Added pagination to the dashboard, user can see the next page by scrolling to the bottom of the page.
All the states are handled properly. User will get 10 data per page.
- **Filter**: Added filter to the dashboard, user can filter the products based on the Brands, Price Range, Gender and Colors.
  - PS- Some filters won't work due to not adding those specific composite indexes in the Firebase Datastore.
- **Sort By**: Added sort by feature to the filter, user can sort the products based on the Price and Created Date.
- **Cart Cache**: Added cart cache to the app, user can see the products which are added to the cart even after closing the app.
- **Order History**: Added order history to the app, user can see the history of the orders which are placed by the user.
- **Review**: Added review feature to the app, user can give review to the product which is already ordered.
- **Performance Optimization**: 
  - Optimized the performance of the app, by paginating the data, using the cache and by using the proper state management.
  - Used CachedImageNetwork to cache the images.
  - Used dependency injection to inject the dependencies and used singleton pattern to avoid multiple instances.
  - Reused the widgets to avoid the unnecessary rebuilds.
  - Used the proper state management to avoid the unnecessary rebuilds.
  - Called Firebase Functions only when needed. (`When getting a product with 0 rating` & `When giving a review`)



