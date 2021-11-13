(require :valkyrie "package://valkyrieus/robots/valkyrie.l")


(defun valkyrie () (setq *valkyrie* (instance valkyrie-robot :init)))
