PHP Eldoc Plugin
====================

This is php-eldoc, a eldoc-mode plugin for PHP source code.
The hash table is mostly based on Arne Jørgensen's php-extras.

Eldoc-mode is a MinorMode which shows you, in the echo area, the argument list of the function call you are currently writing. Very handy. By NoahFriedman. 

Licensing
=========

This software is licensed under the GPL v3

Copyright (C) 2012  Zeno Zeng

Copyright (C) 2012  Arne Jørgensen;


This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
   
Usage
======

```emacs-lisp
(add-hook 'php+-mode-hook
	  '(lambda ()
	     (set
  	      (make-local-variable 'eldoc-documentation-function)
  	      'php-eldoc-function)
 	     (eldoc-mode)))
```
   
