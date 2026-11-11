### Error at level 2
[ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: setState() called after dispose(): _StudentsPageState#5cf43(lifecycle state: defunct, not mounted)
This error happens if you call setState() on a State object for a widget that no longer appears in the widget tree (e.g., whose parent widget no longer includes the widget in its build). This error can occur when code calls setState() from a timer, from an animation callback, or after an asynchronous operation (such as an awaited network request or other Future) completes after the widget has been removed from the tree.
The preferred solution is to cancel the timer or stop listening to the animation in the dispose() callback. Another solution is to check the "mounted" property of this object before calling setState() to ensure the object is still in the tree.
This error might indicate a memory leak if setState() is being called because another object is retaining a reference to this State object after it has been removed from the tree. To avoid memory leaks, consider breaking the reference to this object during dispose().
#0      State.setState.<anonymous closure> (package:flutter/src/widgets/framework.dart:1163:9)
#1      State.setState (package:flutter/src/widgets/framework.dart:1200:6)
#2      _StudentsPageState._load (package:students_async/pages/StudentsPage.dart:39:7)
<asynchronous suspension>

### error at level 5
Null check operator used on a null value