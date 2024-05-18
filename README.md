# Task Manager
> A Flutter Application that allows users to manage their tasks efficiently.

The app boasts a simple User Interface and user-friendly functionalities, allowing you to effortlessly create tasks, mark them as completed, or delete them.

## Instructions for running the app

Open Android Studio or any flutter IDE.
Create new Project from Virsion Control

Past the Project URL

```bash
  https://github.com/AhmedIbrahimFahmy/Task-Manager
```

Go to the project directory

```bash
  cd my-project-directory
```

Install dependencies, write the following command on terminal

```bash
  flutter pub get
```

Build an APK file for the app

```bash
  flutter build apk --release
```

Go to the apk file directory, run it on a physical device to try the app


## Used Packages

A few packages has been used in the app to make it more efficiency and friendly, here is the most important packages:


```bash
  http: ^1.2.1
  #For Handling the APIs requests        
```

```bash
  flutter_bloc: ^8.1.5
  #For the state management in the app
```


```bash
  fluttertoast: ^8.2.5
  #For a pop-up message when the APIs responesed
```


```bash
  shared_preferences: ^2.2.3
  #For handling the local storage
```


## Challenged faced

* Build the User Interface

* Handling the APIs requests:
    * Handling the user authenticate APIs and store the token
    * Handling the task APIs `create`, `update`, `delete`

* Handling state management


## Contact
For any questions or feedback, feel free to reach out:

Email: ahmedibrahim2252@gmail.com

LinkedIn: https://www.linkedin.com/in/ahmed-ibrahim-79b16320b/
