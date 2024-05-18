abstract class TaskStates {}

// Initial State
class TaskInitialState extends TaskStates {}

// Get User's Online Tasks State
class GetUserOnlineTasksState extends TaskStates {}

// Get User's Local Tasks State
class GetUserLocalTasksState extends TaskStates {}

// Clear Tasks State
class ClearMyTasksState extends TaskStates {}

// Add Task States
class AddTaskOnProgressState extends TaskStates {}
class AddTaskFinishedState extends TaskStates {}
class AddTaskFailedState extends TaskStates {}

// Update Task States
class UpdateTaskOnProgressState extends TaskStates {}
class UpdateTaskFinishedState extends TaskStates {}
class UpdateTaskFailedState extends TaskStates {}

// Delete Task States
class DeleteTaskOnProgressState extends TaskStates {}
class DeleteTaskFinishedState extends TaskStates {}
class DeleteTaskFailedState extends TaskStates {}