;;; consult-ghq.el ---  Ghq interface using consult -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Tomoya Otake

;; Author: Tomoya Otake <tomoya.ton@gmail.com>
;; Version: 0.0.5
;; Homepage: https://github.com/tomoya/consult-ghq
;; Keywords: convenience, usability, consult, ghq
;; Package-Requires: ((emacs "26.1") (consult "0.8"))
;; License: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This packaage provides ghq interface using Consult.
;;
;; Its main entry points are the commands `consult-ghq-find' and
;; `consult-ghq-grep`.  Default find-function is affe-find, if it's
;; installed, otherwise consult-find.  If you want to use consult-find
;; despite having affe installed, you can change like below:
;;
;; (setq consult-ghq-find-function #'consult-find)

;;; Code:

(require 'consult)

(defgroup consult-ghq nil
  "Ghq interface using consult."
  :prefix "consult-ghq-"
  :group 'consult)

(defcustom consult-ghq-command
  "ghq"
  "*A ghq command."
  :type 'string
  :group 'consult-ghq)

(defcustom consult-ghq-find-function (if (fboundp 'affe-find)
                                         #'affe-find
                                       #'consult-find)
  "Find function that find files after selected repo."
  :type 'function
  :group 'consult-ghq)

(defcustom consult-ghq-grep-function (if (fboundp 'affe-grep)
                                         #'affe-grep
                                       #'consult-grep)
  "Grep function that find files after selected repo."
  :type 'function
  :group 'consult-ghq)

(defcustom consult-ghq-switch-project-function #'project-switch-project
  "Switch project function that opens a project in that project manager."
  :type 'function
  :group 'consult-ghq)

(defun consult-ghq--list-candidates ()
  "Return ghq list candidate."
  (with-temp-buffer
    (unless (zerop (apply #'call-process
                          consult-ghq-command nil t nil
                          '("list" "--full-path")))
      (error "Failed: Cannot get ghq list candidates"))
    (let ((paths))
      (goto-char (point-min))
      (while (not (eobp))
        (push
         (buffer-substring-no-properties
          (line-beginning-position) (line-end-position))
         paths)
        (forward-line 1))
      (nreverse paths))))

;;;###autoload
(defun consult-ghq-find ()
  "Find file from selected repo using ghq."
  (interactive)
  (let* ((repo (consult--read (consult-ghq--list-candidates) :prompt "Repo: "))
         (default-directory repo))
    (funcall consult-ghq-find-function repo)))

;;;###autoload
(defun consult-ghq-grep ()
  "Grep from selected repo using ghq."
  (interactive)
  (let* ((repo (consult--read (consult-ghq--list-candidates) :prompt "Repo: "))
         (default-directory repo))
    (funcall consult-ghq-grep-function repo)))

;;;###autoload
(defun consult-ghq-switch-project ()
  "Switch project from ghq."
  (interactive)
  (let ((repo (consult--read (consult-ghq--list-candidates) :prompt "Repo: ")))
    (funcall consult-ghq-switch-project-function repo)))

(provide 'consult-ghq)

;;; consult-ghq.el ends here
