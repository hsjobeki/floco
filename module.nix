# Colocation options are seperate from config.
# Writing them in different files makes it harder.
# Options and Attributes should belong together to form components. That can be composed
# Fixpoint is good if you need access to global variables.
# NixOS modules are bad because they add use only the global scope.
#

# Dependency problem
# Problems: We can override modules values without importing (declaring dependency on it)
# Problems: We can depend on other modules values without importing (declaring dependency on it)
#
# This can be prevented by establishing good patterns, but may still happen even to experienced users.
#
#
# We can change values (values should be immutable) When someone needs to change a variable he must create a new value.
# example
# Imagine the default configuration
# foo = {
#   doSth = true;
#   unix = true; 
# }
# ->
# foo = {
#   doSth = true;
#   unix = false; 
# }
# instead of doing
# foo.unix = false 
#
# the user should do this:
# 
# newFoo = foo // {
#   unix = false;
# } 

let
  evalModule = {config, ...}: config;

  fix = f: 
    let x = f x; in x;
  res0 = fix (self: {
    config = {
      a = 1;
      b = self.config.a;
    };
  }); 
in
{
  inherit res0;
}