import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/ui/view_task/view_task.dart';

Widget myTextFormField({
  required TextEditingController controller,
  required String hint,
  TextInputType keyboard = TextInputType.text,
  bool isSecure = false,
  IconData? suffix,
  VoidCallback? suffixCallback,
  String? Function(String?)? validate,
  int? maxLine = 1,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.teal[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white30,
            fontSize: 20,
          ),
          contentPadding:
              EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                    size: 30,
                    color: Colors.grey,
                  ),
                  onPressed: suffixCallback,
                )
              : null,
        ),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        cursorColor: Colors.white,
        obscureText: isSecure,
        validator: validate,
        maxLines: maxLine,
      ),
    );

Widget TaskBuilder(context, int index, Task task) => GestureDetector(
    onTap: ()=> NavigateTo(context, ViewTask(index: index)),
    child: Card(
      elevation: 10,
      color: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(

                decoration: BoxDecoration(
                  color: task.status == 1 ? Colors.green : Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      task.status == 1 ? "completed" : "not completed",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              task.body,
              style: const TextStyle(
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );

myToast({
  required String message,
  Color backgroundColor = Colors.cyan,
}) =>
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
    );


NavigateTo(context, route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

NavigateBack(context) {
  Navigator.pop(context);
}

NavigateToAsFirstRoute(context, route) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => route), (route) => false);
}