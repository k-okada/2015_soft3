#!/usr/bin/env irteusgl

(load "lib/llib/unittest.l")
(init-unit-test)
(send *unit-test* :clear-result)
;; DO NOT EDIT BEFORE THIS LINE

;; 2)
;; サーボモジュールを参考に直動ジョイント(linear-joint)を使ったアクチュエータを作ってみよ．

(defun make-servo nil
  (let (b1 b2)
    (setq b1 (make-cube 30 20 20))
    (send b1 :locate #f(9.5 0 0))
;    (setq b2 (make-cylinder 3 60))
 ;   (send b2 :locate #f(0 0 -30))
    ;(setq b1 (body+ b1 b2))
    (send b1 :set-color :gray20)
    b1))
(defun make-hinji nil
  (let ((b2 (make-cube 22 16 58))
	(b1 (make-cube 26 20 54)))
    (send b2 :locate #f(-4 0 0))
    (setq b3 (make-cylinder 3 60))
    (send b3 :locate #f(0 0 -30))
    (setq b2 (body- b2 b1))
    (setq b2 (body+ b2 b3))
    (send b1 :set-color :gray80)
    (setq b3 (make-cylinder 3 60))
    (send b3 :locate #f(0 0 -30))
    b2))
(setq h1 (instance bodyset-link :init (make-cascoords) :bodies (list (make-hinji))))
(setq s1 (instance bodyset-link :init (make-cascoords) :bodies (list (make-servo))))
(setq j1 (instance linear-joint :init :parent-link h1 :child-link s1 :axis :z))

(setq r (instance cascaded-link :init))
(send r :assoc h1)
(send h1 :assoc s1)
(setq (r . links) (list h1 s1))
(setq (r . joint-list) (list j1))
(send r :init-ending)
(objects (list r))
(objects r)

;; DO NOT EDIT AFTER THIS LINE
(send *unit-test* :print-result)
(exit 1)



