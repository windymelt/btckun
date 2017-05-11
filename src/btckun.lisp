(in-package :cl-user)
(defpackage btckun
  (:use :cl)
  (:export #:bootstrap))
(in-package :btckun)

(defun get-ticker ()
  (pushnew (cons "application" "json") drakma:*text-content-types*
           :test #'equal)
  (json:decode-json-from-string
   (dex:get "https://api.bitflyer.jp/v1/ticker" :insecure t)))

(defun ticker-reform (ticker)
  (format nil "~s: 売値: ~s / 買値: ~s [~s] 出来高: ~s"
          (cdr (assoc :product--code ticker))
          (cdr (assoc :best--bid ticker))
          (cdr (assoc :best--ask ticker))
          (cdr (assoc :timestamp ticker))
          (cdr (assoc :volume ticker))))

(defun bootstrap ()
  (progn
    (format t "Initializing RTM...~&")
    (let ((client (make-instance 'sc:slack-client)))
    ;;; You can use :* for all event type;
    ;;; (sc:bind :* client
    ;;;   (lambda (ev) ...
      (format t "RTM client is set up")
      ;;(sc:bind :* client (lambda (ev) (format t "~s" ev)))
      (sc:bind "hello" client
               (lambda (ev)
                 (declare (ignore ev))
                 (format t "connected.~%")))
      (sc:bind "message" client
               (lambda (ev)
                 (sc:with-data-let ev (channel user text)
                   (let* ((c (sc:channel-id-channel client channel))
                          (cname (sc:afind c "name"))
                          (u (sc:user-id-user client user))
                          (uname (sc:afind u "name"))
                          (botp (sc:afind u "is_bot")))
                     (format t "~A:~A~:[~;(bot)~]: ~A~%" cname uname botp text)
                     (when (equal text "btckun ticker")
                       (handler-case
                           (sc:send-text client channel (ticker-reform (get-ticker)))
                         (error (c) (sc:send-text client channel (format nil "[btckun] Exception raised:~&~s" c)))))))))
      (as:with-event-loop ()
        (as:signal-handler
         as:+sigint+ (lambda (sig)
                       (declare (ignore sig))
                       (as:exit-event-loop)))
        (sc:run-client client)))))
