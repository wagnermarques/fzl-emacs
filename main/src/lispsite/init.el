(setq debug-on-error t)

;; add this init.el dir to load-path
;; it is needed to require another el files
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)

(require 'defaults-custom)
