;;; package --- Summary

;;; Commentary:
;;; https://github.com/thierryvolpiatto/emacs-config/blob/main/init-helm.el
;;  ac-helm                        20160319.233   available    melpa    Helm interface for auto-complete
;;  ace-jump-helm-line             20160918.1836  available    melpa    Ace-jump to a candidate in helm window
;;  all-ext                        20200315.1443  available    melpa    M-x all with helm-swoop/anything/multiple-cursors/line-number
;;  esqlite-helm                   20151116.850   available    melpa    Define helm source for sqlite database
;;  flyspell-correct-helm          20220520.630   available    melpa    Correcting words with flyspell via helm interface
;;  geben-helm-projectile          20170524.334   available    melpa    Integrate helm-projectile with geben
;;  gitlab-snip-helm               20200427.2014  available    melpa    Gitlab snippets api helm package
;;  helm-R                         20120820.14    available    melpa    helm-sources and some utilities for GNU R.
;;  helm-ack                       20141030.1226  available    melpa    Ack command with helm interface
;;  helm-ad                        20151209.1015  available    melpa    helm source for Active Directory
;;  helm-ag                        20221017.1528  available    melpa    The silver searcher with helm interface
;;  helm-apt                       20210324.1929  available    melpa    Helm interface for Debian/Ubuntu packages (apt-*)
;;  helm-atoms                     20201013.1723  available    melpa    Reverse variable lookup using Helm
;;  helm-aws                       20180514.1032  available    melpa    Manage AWS EC2 server instances directly from Emacs
;;  helm-backup                    20180911.614   available    melpa    Backup each file change using git
;;  helm-bbdb                      20190728.1325  available    melpa    Helm interface for bbdb
;;  helm-bibtex                    20221114.1204  available    melpa    A bibliography manager based on Helm
;;  helm-bibtexkey                 20140214.1504  available    melpa    Bibtexkey source for helm
;;  helm-bind-key                  20141109.515   available    melpa    helm-source for for bind-key.
;;  helm-bitbucket                 20220722.1538  available    melpa    Search Bitbucket with Helm
;;  helm-bm                        20160321.1331  available    melpa    helm sources for bm.el
;;  helm-books                     20170325.631   available    melpa    Helm interface for searching books
;;  helm-bufler                    20210708.2217  available    melpa    Helm source for Bufler
;;  helm-bundle-show               20190526.1401  available    melpa    Bundle show with helm interface
;;  helm-c-moccur                  20151230.924   available    melpa    helm source for color-moccur.el
;;  helm-c-yasnippet               20210330.16    available    melpa    helm source for yasnippet.el
;;  helm-catkin                    20190425.1520  available    melpa    Package for compile ROS workspaces with catkin-tools
;;  helm-charinfo                  20170810.1231  available    melpa    A helm source for character information
;;  helm-chrome                    20160719.520   available    melpa    Helm interface for Chrome bookmarks
;;  helm-chrome-control            20190707.1807  available    melpa    Control Chrome tabs with Helm (macOS only)
;;  helm-chrome-history            20191031.1233  available    melpa    Browse Chrome History with Helm
;;  helm-chronos                   20150528.2036  available    melpa    helm interface for chronos timers
;;  helm-cider                     20220706.944   available    melpa    Helm interface to CIDER
;;  helm-cider-history             20150719.2120  available    melpa    Helm interface for cider history
;;  helm-circe                     20160207.652   available    melpa    helm circe buffer management.
;;  helm-clojuredocs               20160405.723   available    melpa    search for help in clojuredocs.org
;;  helm-codesearch                20221219.1219  available    melpa    helm interface for codesearch
;;  helm-commandlinefu             20150611.545   available    melpa    Search and browse commandlinefu.com from helm
;;  helm-company                   20190812.1429  available    melpa    Helm interface for company-mode
;;  helm-cscope                    20190615.41    available    melpa    Helm interface for xcscope.el.
;;  helm-css-scss                  20230522.1113  available    melpa    CSS/SCSS/LESS Selectors with helm interface
;;  helm-ctest                     20220721.400   available    melpa    Run ctest from within emacs
;;  helm-dash                      20190527.1118  available    melpa    Offline documentation browser for +150 APIs using Dash docsets.
;;  helm-descbinds                 20190501.935   available    melpa    A convenient `describe-bindings' with `helm'
;;  helm-describe-modes            20160212.518   available    melpa    Helm interface to major and minor modes.
;;  helm-dictionary                20220514.714   available    melpa    Helm source for looking up dictionaries
;;  helm-directory                 20170709.1103  available    melpa    selecting directory before select the file
;;  helm-dired-history             20170524.1046  available    melpa    Show dired history with helm.el support.
;;  helm-dired-recent-dirs         20131228.1414  available    melpa    Show recent dirs with helm.el support.
;;  helm-dogears                   20230608.356   available    melpa    Helm source for Dogears
;;  helm-emmet                     20160713.1231  available    melpa    helm sources for emmet-mode's snippets
;;  helm-emms                      20220314.1633  available    melpa    Emms for Helm.
;;  helm-esa                       20190721.1429  available    melpa    Esa with helm interface
;;  helm-etags-plus                20201003.1424  available    melpa    Another Etags helm.el interface
;;  helm-evil-markers              20200506.715   available    melpa    Show evil markers with helm
;;  helm-eww                       20190315.907   available    melpa    Helm UI wrapper for EWW.
;;  helm-ext                       20200722.107   available    melpa    A few extensions to Helm
;;  helm-exwm                      20210215.858   available    melpa    Helm for EXWM buffers
;;  helm-file-preview              20220720.531   available    melpa    Preview the current helm file selection
;;  helm-filesets                  20140929.1835  available    melpa    A helm source for emacs filesets
;;  helm-firefox                   20220420.1346  available    melpa    Firefox bookmarks
;;  helm-fish-completion           20200908.1504  available    melpa    Helm interface for fish completion
;;  helm-flx                       20221020.1739  available    melpa    Sort helm candidates by flx score
;;  helm-flycheck                  20160710.829   available    melpa    Show flycheck errors with helm
;;  helm-flymake                   20160610.2     available    melpa    helm interface for flymake
;;  helm-flyspell                  20170210.1901  available    melpa    Helm extension for correcting words with flyspell
;;  helm-frame                     20220803.1528  available    melpa    open helm buffers in a dedicated frame
;;  helm-fuz                       20200812.1222  available    melpa    Integrate Helm and Fuz
;;  helm-fuzzier                   20160605.2145  available    melpa    Better fuzzy matching for Helm
;;  helm-fuzzy                     20220704.651   available    melpa    Fuzzy matching for helm source
;;  helm-fuzzy-find                20171106.400   available    melpa    Find file using Fuzzy Search
;;  helm-ghq                       20210724.744   available    melpa    Ghq with helm interface
;;  helm-ghs                       20170715.541   available    melpa    ghs with helm interface
;;  helm-git                       20120630.2103  available    melpa    Helm extension for Git.
;;  helm-git-grep                  20170614.1411  available    melpa    helm for git grep, an incremental git-grep(1)
;;  helm-github-stars              20190428.1047  available    melpa    Helm interface for your github's stars
;;  helm-gitignore                 20230310.1829  available    melpa    Generate .gitignore files with gitignore.io.
;;  helm-gitlab                    20180312.1647  available    melpa    Helm interface to Gitlab
;;  helm-go-package                20161103.153   available    melpa    helm sources for Go programming language's package
;;  helm-google                    20210527.900   available    melpa    Emacs Helm Interface for quick Google searches
;;  helm-grepint                   20200811.1616  available    melpa    Generic helm interface to grep
;;  helm-growthforecast            20140120.344   available    melpa    helm extensions for growthforecast.
;;  helm-gtags                     20200602.1610  available    melpa    GNU GLOBAL helm interface
;;  helm-hatena-bookmark           20210724.732   available    melpa    Hatena::Bookmark with helm interface
;;  helm-hayoo                     20151014.651   available    melpa    Source and configured helm for searching hayoo
;;  helm-helm-commands             20130902.1748  available    melpa    List all helm commands with helm
;;  helm-hoogle                    20161027.534   available    melpa    Use helm to navigate query results from Hoogle
;;  helm-hunks                     20171217.1933  available    melpa    A helm interface for git hunks - browsing, staging, unstaging and killing
;;  helm-icons                     20230506.432   available    melpa    Helm icons
;;  helm-idris                     20141202.1757  available    melpa    A Helm datasource for Idris documentation, queried from the compiler
;;  helm-img                       20151224.2321  available    melpa    Utilities for making image sources for helm.
;;  helm-img-tiqav                 20151224.2322  available    melpa    An helm-source for joking.
;;  helm-ispell                    20220721.323   available    melpa    ispell-complete-word with helm interface
;;  helm-itunes                    20151013.648   available    melpa    Play local iTunes and Spotify tracks
;;  helm-j-cheatsheet              20170217.829   available    melpa    Quick J reference for Emacs
;;  helm-jira                      20180802.815   available    melpa    Helm bindings for JIRA/Bitbucket/stash
;;  helm-js-codemod                20190921.942   available    melpa    A helm interface for running js-codemods
;;  helm-jstack                    20150603.422   available    melpa    Helm interface to Jps & Jstack for Java/JVM processes
;;  helm-kythe                     20170709.726   available    melpa    Google Kythe helm interface
;;  helm-lastpass                  20180722.806   available    melpa    Helm interface of LastPass
;;  helm-lean                      20210305.1705  available    melpa    Helm interfaces for lean-mode
;;  helm-lib-babel                 20180510.1324  available    melpa    helm insertion of babel function references
;;  helm-lines                     20220103.1909  available    melpa    A helm interface for completing by lines
;;  helm-lobsters                  20150213.1546  available    melpa    helm front-end for lobste.rs
;;  helm-ls-git                    20230505.1437  available    melpa    list git files.
;;  helm-ls-hg                     20150909.543   available    melpa    List hg files in hg project.
;;  helm-ls-svn                    20190316.2203  available    melpa    helm extension to list svn files
;;  helm-lsp                       20210419.2014  available    melpa    LSP helm integration
;;  helm-lxc                       20200323.816   available    melpa    Helm interface to manage LXC containers
;;  helm-make                      20200620.27    available    melpa    Select a Makefile target with helm
;;  helm-migemo                    20151010.356   available    melpa    Migemo plug-in for helm
;;  helm-mode-manager              20210108.2330  available    melpa    Select and toggle major and minor modes with helm
;;  helm-mt                        20160918.452   available    melpa    helm multi-term management
;;  helm-mu                        20230408.2126  available    melpa    Helm search for e-mails and contacts in mu4e
;;  helm-navi                      20230517.1143  available    melpa    Helm for navi-mode
;;  helm-nixos-options             20151013.2309  available    melpa    Helm Interface for nixos-options
;;  helm-notmuch                   20190320.1048  available    melpa    Search emails with Notmuch and Helm
;;  helm-open-github               20220721.415   available    melpa    Utilities of Opening Github Page
;;  helm-org                       20210324.1927  available    melpa    Helm for org headlines and keywords completion
;;  helm-org-multi-wiki            20210228.1853  available    melpa    Helm interface to org-multi-wiki
;;  helm-org-ql                    20230310.1225  available    melpa    Helm support for org-ql
;;  helm-org-recent-headings       20211011.1519  available    melpa    Helm source for org-recent-headings
;;  helm-org-rifle                 20221024.1943  available    melpa    Rifle through your Org files
;;  helm-orgcard                   20220721.756   available    melpa    browse the orgcard by helm
;;  helm-osx-app                   20190717.958   available    melpa    Launch macOS apps with helm
;;  helm-pages                     20161121.226   available    melpa    Pages in current buffer as Helm datasource
;;  helm-pass                      20210221.1655  available    melpa    helm interface of pass, the standard Unix password manager
;;  helm-perldoc                   20220721.431   available    melpa    perldoc with helm interface
;;  helm-perspeen                  20170228.1345  available    melpa    Helm interface for perspeen.
;;  helm-phpunit                   20160513.853   available    melpa    Helm integration for phpunit.el
;;  helm-posframe                  20211103.236   available    melpa    Using posframe to show helm window
;;  helm-proc                      20161006.305   available    melpa    Helm interface for managing system processes
;;  helm-project-persist           20151210.1543  available    melpa    Helm integration for project-persist package
;;  helm-projectile                20221215.613   available    melpa    Helm integration for Projectile
;;  helm-prosjekt                  20140129.717   available    melpa    Helm integration for prosjekt.
;;  helm-pt                        20160214.2342  available    melpa    Helm interface to the platinum searcher
;;  helm-purpose                   20170114.1636  available    melpa    Helm Interface for Purpose
;;  helm-pydoc                     20220721.433   available    melpa    pydoc with helm interface
;;  helm-qiita                     20190526.1359  available    melpa    Qiita with helm interface
;;  helm-rage                      20180118.1532  available    melpa    Helm command for rage characters.
;;  helm-rails                     20130424.1519  available    melpa    Helm extension for Rails projects.
;;  helm-rdefs                     20161130.536   available    melpa    rdefs with helm interface
;;  helm-recoll                    20220920.1206  available    melpa    helm interface for the recoll desktop search tool.
;;  helm-rg                        20200721.725   available    melpa    a helm interface to ripgrep
;;  helm-rhythmbox                 20160524.1158  available    melpa    control Rhythmbox's play queue via Helm
;;  helm-robe                      20151209.355   available    melpa    completing read function for robe
;;  helm-ros                       20160812.1752  available    melpa    Interfaces ROS with helm
;;  helm-rtags                     20191222.920   available    melpa    A front-end for rtags
;;  helm-rubygems-local            20130712.111   available    melpa    Installed local rubygems find-file for helm
;;  helm-rubygems-org              20140826.1156  available    melpa    Use helm to search rubygems.org
;;  helm-safari                    20160404.324   available    melpa    Browse your Safari bookmarks and history
;;  helm-sage                      20160514.745   available    melpa    A helm extension for sage-shell-mode.
;;  helm-searcher                  20221231.1632  available    melpa    Helm interface to use searcher
;;  helm-selected                  20171223.210   available    melpa    helm extension for selected.el
;;  helm-selector                  20210125.857   available    melpa    Helm buffer selector
;;  helm-sheet                     20130630.1239  available    melpa    helm sources for sheet
;;  helm-shell-history             20210214.948   available    melpa    Find shell history from helm
;;  helm-slime                     20191016.1601  available    melpa    helm-sources and some utilities for SLIME.
;;  helm-sly                       20210205.1424  available    melpa    Helm sources and some utilities for SLY.
;;  helm-smex                      20171004.2008  available    melpa    Helm interface for smex
;;  helm-spaces                    20161001.1409  available    melpa    helm sources for spaces
;;  helm-spotify                   20160905.2147  available    melpa    Control Spotify with Helm.
;;  helm-spotify-plus              20190913.2236  available    melpa    Control Spotify search and select music with Helm.
;;  helm-sql-connect               20170319.1251  available    melpa    Choose a database to connect to via Helm.
;;  helm-switch-shell              20210713.1440  available    melpa    A Helm source for switching between shell buffers
;;  helm-switch-to-repl            20210206.844   available    melpa    Helm action to switch directory in REPLs
;;  helm-swoop                     20210426.547   available    melpa    Efficiently hopping squeezed lines powered by helm interface
;;  helm-system-packages           20220515.812   available    melpa    Helm UI wrapper for system package managers.
;;  helm-systemd                   20210105.542   available    melpa    helm's systemd interface
;;  helm-tail                      20220726.947   available    melpa    Read recent output from various sources
;;  helm-taskswitch                20221019.1542  available    melpa    Use helm to switch windows and buffers
;;  helm-themes                    20220721.330   available    melpa    Color theme selection with helm interface
;;  helm-tramp                     20221228.1444  available    melpa    Tramp helm interface for ssh, docker, vagrant
;;  helm-tree-sitter               20220328.1345  available    melpa    Helm interface for tree-sitter
;;  helm-twitch                    20220420.1625  available    melpa    Navigate Twitch.tv via `helm'
;;  helm-unicode                   20180608.1407  available    melpa    Helm command for unicode characters.
;;  helm-w32-launcher              20141223.2014  available    melpa    Start Menu entry launcher using Helm
;;  helm-w3m                       20210315.723   available    melpa    W3m bookmark - helm interface.
;;  helm-wikipedia                 20221113.824   available    melpa    Wikipedia suggestions
;;  helm-wordnet                   20160128.1507  available    melpa    Helm interface to local wordnet dictionary
;;  helm-xcdoc                     20160116.1018  available    melpa    Search Xcode Document by docsetutil and eww with helm interface
;;  helm-xref                      20211017.1334  available    melpa    Helm interface for xref results
;*;  helm-youtube                   20190101.1733  available    melpa    Query YouTube and play videos in your browser
;;  helm-z                         20171204.325   available    melpa    Show z directory list with helm.el support.
;;  helm-zhihu-daily               20160625.1145  available    melpa    Helm interface for 知乎日报 (http://daily.zhihu.com)
;;  help-find                      20220929.822   available    melpa    Additional help functions for working with keymaps
;;  org-books                      20210408.1913  available    melpa    Reading list management with Org mode and helm
;;
;;;;; Code:
(use-package helm
  :ensure t
  :config
  (progn
    (helm-mode t))
  
  :bind (("M-x" . helm-M-x)
         ("C-x b" . helm-buffers-list)
         ("C-x C-f" . helm-find-files)))


(setq helm-autoresize-max-height 40
      helm-autoresize-min-height 20
      helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t
      helm-locate-fuzzy-match t)

(provide 'helm-config)

