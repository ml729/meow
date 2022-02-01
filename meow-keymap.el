;;; meow-keymap.el --- Default keybindings for Meow  -*- lexical-binding: t; -*-

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; Default keybindings.

;;; Code:

(require 'meow-var)

(defvar meow-keymap
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap [remap describe-key] #'meow-describe-key)
    keymap)
  "Global keymap for Meow.")

(defvar meow-insert-state-keymap
  (let ((keymap (make-keymap)))
    (define-key keymap [escape] 'meow-insert-exit)
    (define-key keymap [remap kmacro-start-macro] #'meow-start-kmacro)
    (define-key keymap [remap kmacro-start-macro-or-insert-counter] #'meow-start-kmacro-or-insert-counter)
    (define-key keymap [remap kmacro-end-or-call-macro] #'meow-end-or-call-kmacro)
    (define-key keymap [remap kmacro-end-macro] #'meow-end-kmacro)
    keymap)
  "Keymap for Meow insert state.")

(defvar meow-numeric-argument-keymap
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "1") 'digit-argument)
    (define-key keymap (kbd "2") 'digit-argument)
    (define-key keymap (kbd "3") 'digit-argument)
    (define-key keymap (kbd "4") 'digit-argument)
    (define-key keymap (kbd "5") 'digit-argument)
    (define-key keymap (kbd "6") 'digit-argument)
    (define-key keymap (kbd "7") 'digit-argument)
    (define-key keymap (kbd "8") 'digit-argument)
    (define-key keymap (kbd "9") 'digit-argument)
    (define-key keymap (kbd "0") 'digit-argument)
    keymap))

(defvar meow-normal-state-keymap
  (let ((keymap (make-keymap)))
    (suppress-keymap keymap t)
    (define-key keymap (kbd "SPC") 'meow-keypad)
    (define-key keymap (kbd "i") 'meow-insert)
    (define-key keymap (kbd "a") 'meow-append)
    (define-key keymap [remap kmacro-start-macro] #'meow-start-kmacro)
    (define-key keymap [remap kmacro-start-macro-or-insert-counter] #'meow-start-kmacro-or-insert-counter)
    (define-key keymap [remap kmacro-end-or-call-macro] #'meow-end-or-call-kmacro)
    (define-key keymap [remap kmacro-end-macro] #'meow-end-kmacro)
    keymap)
  "Keymap for Meow normal state.")

(defvar meow-motion-state-keymap
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap [escape] 'meow-last-buffer)
    (define-key keymap (kbd "SPC") 'meow-keypad)
    keymap)
  "Keymap for Meow motion state.")

(defvar meow-keypad-state-keymap
  (let ((keymap (make-sparse-keymap)))
    keymap)
  "Keymap for Meow keypad state.")

(defvar meow-beacon-state-keymap
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map meow-normal-state-keymap)
    (suppress-keymap map t)

    ;; kmacros
    (define-key map [remap meow-insert] 'meow-beacon-insert)
    (define-key map [remap meow-append] 'meow-beacon-append)
    (define-key map [remap meow-change] 'meow-beacon-change)
    (define-key map [remap meow-replace] 'meow-beacon-replace)
    (define-key map [remap meow-kill] 'meow-beacon-kill-delete)

    (define-key map [remap kmacro-end-or-call-macro] 'meow-beacon-apply-kmacro)
    (define-key map [remap kmacro-start-macro-or-insert-counter] 'meow-beacon-start)
    (define-key map [remap kmacro-start-macro] 'meow-beacon-start)

    (define-key map [remap meow-start-kmacro] 'meow-beacon-start)
    (define-key map [remap meow-start-kmacro-or-insert-counter] 'meow-beacon-start)
    (define-key map [remap meow-end-or-call-kmacro] 'meow-beacon-apply-kmacro)

    ;; noops
    (define-key map [remap meow-delete] 'meow-beacon-noop)
    (define-key map [remap meow-C-d] 'meow-beacon-noop)
    (define-key map [remap meow-C-k] 'meow-beacon-noop)
    (define-key map [remap meow-save] 'meow-beacon-noop)
    (define-key map [remap meow-insert-exit] 'meow-beacon-noop)
    (define-key map [remap meow-last-buffer] 'meow-beacon-noop)
    (define-key map [remap meow-open-below] 'meow-beacon-noop)
    (define-key map [remap meow-open-above] 'meow-beacon-noop)
    (define-key map [remap meow-swap-grab] 'meow-beacon-noop)
    (define-key map [remap meow-sync-grab] 'meow-beacon-noop)
    (define-key map [remap meow-keypad-start] 'meow-beacon-disallow-keypad-start)
    (define-key map [remap meow-keypad] 'meow-beacon-disallow-keypad-start)
    map)
  "Keymap for Meow cursor state.")

(defvar meow-keymap-alist
  `((insert . ,meow-insert-state-keymap)
    (normal . ,meow-normal-state-keymap)
    (keypad . ,meow-keypad-state-keymap)
    (motion . ,meow-motion-state-keymap)
    (beacon . ,meow-beacon-state-keymap))
  "Alist of symbols of state names to keymaps.")

(provide 'meow-keymap)
;;; meow-keymap.el ends here
