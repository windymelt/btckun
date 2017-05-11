#|
  This file is a part of btckun project.
|#

#|
  bitcoin bot
|#

(in-package :cl-user)
(defpackage btckun-asd
  (:use :cl :asdf))
(in-package :btckun-asd)

(defsystem btckun
  :version "0.1"
  :author ""
  :license ""
  :depends-on ("cl-json" "slack-client" "dexador")
  :components ((:module "src"
                :components
                ((:file "btckun"))))
  :description "bitcoin bot"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op btckun-test))))
