;;3b7ffed2a02e   portainer/portainer-ce:latest         "/portainer"             4 hours ago    Up 4 hours               0.0.0.0:9000->9000/tcp, [::]:9000->9000/tcp, 8000/tcp, 9443/tcp, 0.0.0.0:9043->9043/tcp, [::]:9043->9043/tcp   fzl-portainer
;;e934cb8eb2a1   fzlbpms-fzl-nexus                     "/opt/sonatype/nexus…"   4 hours ago    Up 4 hours (unhealthy)   0.0.0.0:8082->8082/tcp, [::]:8082->8082/tcp, 0.0.0.0:8088->8081/tcp, [::]:8088->8081/tcp                       fzl-nexus
;;aaec5dfe3826   fzlbpms-fzl-karaf-camel-integration   "entrypoint.sh /opt/…"   4 hours ago    Up 4 hours               1099/tcp, 8101/tcp, 8181/tcp, 44444/tcp                                                                        fzl-karaf-camel-integration
;;56a4089b6b47   fzlbpms-fzl-postgresql                "docker-entrypoint.s…"   4 hours ago    Up 4 hours (healthy)     0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp                                                                    fzl-postgresql
;;59fca4cf987e   phpmyadmin/phpmyadmin                 "/docker-entrypoint.…"   3 weeks ago    Up 4 hours               0.0.0.0:8889->80/tcp, [::]:8889->80/tcp                                                                        fzl-phpmyadmin
;;d63c43820c52   fzlbpms-fzl-kibana                    "/bin/tini -- /usr/l…"   3 weeks ago    Up 4 hours               0.0.0.0:5601->5601/tcp, [::]:5601->5601/tcp                                                                    fzl-kibana
;;5a02718554a0   fzlbpms-fzl-php8.3-fpm                "docker-entrypoint.s…"   3 weeks ago    Up 4 hours               9000/tcp                                                                                                       fzl-php8.3-fpm
;;da6fd8ac10e2   mongo:4.4                             "docker-entrypoint.s…"   3 weeks ago    Up 4 hours (healthy)     27017/tcp                                                                                                      fzl-mongodb
;;748dfe20e41f   fzlbpms-fzl-nginx                     "/docker-entrypoint.…"   3 weeks ago    Up 4 hours               0.0.0.0:80->80/tcp, [::]:80->80/tcp, 0.0.0.0:8899-8900->8899-8900/tcp, [::]:8899-8900->8899-8900/tcp           fzl-nginx
;;885e3f0802d8   fzlbpms-fzl-php8.1-fpm                "docker-php-entrypoi…"   3 weeks ago    Up 4 hours               9000/tcp                                                                                                       fzl-php8.1-fpm
;;66bcac86366f   fzlbpms-fzl-elasticsearch             "/bin/tini -- /usr/l…"   3 weeks ago    Up 4 hours (unhealthy)   0.0.0.0:9200->9200/tcp, [::]:9200->9200/tcp, 9300/tcp                                                          fzl-elasticsearch
;;3108d595d7e6   redis:7-alpine                        "docker-entrypoint.s…"   3 weeks ago    Up 4 hours (healthy)     6379/tcp                                                                                                       fzl-redis
;;f7f92edb7a8b   mysql:8.0                             "docker-entrypoint.s…"   3 weeks ago    Up 4 hours               33060/tcp, 0.0.0.0:3316->3306/tcp, [::]:3316->3306/tcp                                                         fzl-mysql
;;9aadef804610   gessnerfl/fake-smtp-server:latest     "java -Djava.securit…"   3 weeks ago    Up 4 days                                                                                                                               fzl-fakemail


(setq fzlbpms-portainer-port "9000")
(setq fzlbpms-portainer-url (concat  "http://localhost:" fzlbpms-portainer-port))




(defun fzlbpms-open-url-in-browser (url)
  "Open the specified URL in the default web browser."
  (interactive "sEnter URL: ")
  (browse-url url))




(defun fzlbpms-portainer-open-in-browser()
  "Open portainer in default browser."
  (interactive)
  (fzlbpms-open-url-in-browser fzlbpms-portainer-url))

(defun fzlbpms-portainer-open-in-browser-fzlbpms-stack()
  "Open portainer in default browser."
  (interactive)
  (progn
    (let ((url (concat fzlbpms-portainer-url "/#!/3/docker/stacks/fzlbpms?type=2&external=true")))
      (message (concat "###Opening" url))
      (fzlbpms-open-url-in-browser url))))




(provide 'fzlbpms-routes)

