#|
  This file is a part of btckun project.
|#

(in-package :cl-user)
(defpackage btckun-test-asd
  (:use :cl :asdf))
(in-package :btckun-test-asd)

(defsystem btckun-test
  :author ""
  :license ""
  :depends-on (:btckun
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "btckun"))))
  :description "Test system for btckun"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
