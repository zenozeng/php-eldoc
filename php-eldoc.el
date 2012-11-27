;;; php-eldoc.el --- eldoc-mode plugin for PHP source code

;; Copyright (C) 2012  Zeno Zeng

;; Author: Zeno Zeng <zenoes@qq.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; config

;; (add-hook 'php+-mode-hook
;; 	  '(lambda ()
;; 	     (set
;; 	      (make-local-variable 'eldoc-documentation-function)
;; 	      'php-eldoc-function)
;; 	     (eldoc-mode)))

;; TODO: Highlighting Eldoc Arguments

;; 不支持跨行参数

;;; Code:
(eval-when-compile
  (require 'cl nil t))

(defun php-eldoc-function ()
  "Get function arguments for PHP function at point."
  (when (require 'php-extras-eldoc-functions)
    (gethash
     (ignore-errors
       (php-eldoc-get-function-name))
     php-extras-function-arguments)))

(defun php-eldoc-get-function-name ()
  ""
  (interactive)
  (save-excursion
    (save-restriction
      (narrow-to-region (line-beginning-position) (point))

      ;; 跳过内部的函数_如跳过内部的gileget()__ fileget( gileget() , 'and');
      ;; 并前进到函数名称末尾
      (let* ((right 0)
	     (left 0))

	(while (and
		(<= left right)
		(re-search-backward-greedy "\\((\\|)\\)" nil t))
	  (if (equal (buffer-substring-no-properties
		      (point)
		      (+ (point) 1))
		     "(")
	      (setq left (+ left 1))
	    (setq right (+ right 1))))

	(while
	    (equal (buffer-substring-no-properties
		    (- (point) 1)
		    (point))
		   " ")
	  (goto-char (- (point) 1)))


	(let* ((function-name-end (point))
	       (function-name-beg (or
				   (let* ((x (re-search-backward "(" nil t)))
				     (if x
					 (+ x 1)
				       nil))
				   (re-search-backward "[ ]+" nil t)
				   (point-min))))
	  (replace-regexp-in-string " " "" 
				    (buffer-substring-no-properties	
				     function-name-beg
				     function-name-end)))))))

(provide 'php-eldoc)
;;; php-eldoc.el ends here
