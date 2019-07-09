
(cl:in-package :asdf)

(defsystem "ros_kcf-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "InitRect" :depends-on ("_package_InitRect"))
    (:file "_package_InitRect" :depends-on ("_package"))
  ))