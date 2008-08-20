= restarts

http://github.com/archit/restarts/tree/master

== DESCRIPTION:

restarts.rb implements a new method Kernel#raise_condition which
is similar to Kernel#raise for throwing exceptions, with the added feature
of adding "restarts" next to the place where the exception is thrown so
that they can be invoked from the exception handler somewhere higher
up in the stack.

== FEATURES/PROBLEMS:

* kicks ass

== SYNOPSIS:

def do_stuff()
  error_occured = do_something()
  if error_occured
    raise_with_restarts(MyException.new(...)) { |restart_id|
      case restart_id
      when :ID1 then do_something_more()
      when :ID2 then do_something_even_more()
      end
    }
  end
end

begin
  do_stuff()
rescue MyException
  $!.restart(:ID1) if (boolean expression inolving $! data)
end

== REQUIREMENTS:

None whatsoever

== INSTALL:

sudo gem install restarts

== LICENSE:

(The MIT License)

Copyright (c) 2008 Archit Baweja

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
