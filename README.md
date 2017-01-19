# Lisp Interpreter

This is the result of me having a few hours in between classes and needing to kill a little bit of time. It's a functional Lisp interpreter developed using Ruby. It's very basic as of now and doesn't support too many Lisp keywords. There is obviously still a lot more features to implement, and I definitely hope to add them soon!

As of now, it supports the following functions:
```lisp
+, -, *, /, max, min, rem, abs, eq?, define
```

# Usage

The best way to use the interpreter is to directly type Lisp into the REPL. You can access the REPL by running ```repl.rb```, make sure that you have ```lisp.rb``` in the same directory.

If you'd like, you can also pass in a Lisp file. You'd want to set it up similar to how it's set up in ```main.rb```. I plan on adding better support for files soon.
