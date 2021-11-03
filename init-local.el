;;; init-local.el --- Personalized Configuration file 
;;; Commentary: 

(setq inhibit-startup-message t)     ; Don't want any startup message.
(set-face-attribute 'default nil :height 175) ; Change default font size

; This part of the code is to automatically download and install packages
; from MELPA. I do not understand the code yet. I got it from 
; https://emacs.stackexchange.com/questions/28932/
;	how-to-automate-installation-of-packages-with-emacs-file
(require 'package)
(setq package-archives
      '(
        ("melpa" . "http://melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/");  Only for AucTeX.
        )
      )

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

;; ; Code for matlab mode. Copied from https://www.emacswiki.org/emacs/MatlabMode
;; ; and Nick Higham's .emacs file 
;; ; from https://github.com/higham/dot-emacs/blob/master/.emacs
;; (use-package matlab-mode
;;   :mode ("\\.m\\'" . matlab-mode)
;;   :init (autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
;;   :commands (matlab-load)
;;   :config
;;   (matlab-load)
;;   (setq matlab-indent-function t)
;;   )


;; (setq matlab-shell-command "matlab")
;; (setq matlab-shell-command "/Applications/MATLAB_R2019a.app/bin/matlab")
;; (setq matlab-shell-command-switches (list "-nodesktop"))

;; load custom theme
(use-package zenburn-theme
             :ensure t)
(load-theme 'wombat t)

;; ;; load helm-bibtex
;; (use-package helm-bibtex
;;    :ensure t)

;; use undo tree
(use-package undo-tree
             :ensure t)

;; use undo tree
(use-package hydra
             :ensure t)

;; use outline-minor-mode along with outshine-mode for code folding
;; (setq-default outline-minor-mode t)
;; (let ((map outline-minor-mode-map)) 
;;   (define-key map (kbd "<backtab>") 'outline-hide-body)
;;   (define-key map (kbd "C-<tab>") 'outline-show-all)
;;   (define-key map (kbd "M-<left>") 'outline-hide-subtree)
;;   (define-key map (kbd "M-<right>") 'outline-show-subtree))

;; Basic Keybindings of AucTex and RefTex can be found here
;; https://tex.stackexchange.com/questions/20843/useful-shortcuts-or-key-bindings-or-predefined-commands-for-emacsauctex
;; load and customize auctex
                                                        ; (use-package auctex
                                                        ;    :ensure t)

;; Below customization codes from Nick Higham's .emacs file
(setq TeX-parse-self t)                 ; Enable parse on load.
(setq TeX-PDF-mode t)
(setq TeX-save-query nil); No autosave before compiling
(setq TeX-quote-after-quote 1); Now fancy quotes only on hitting "".
; Turn off AucTex special fonts for subscripts etc.
(setq font-latex-fontify-script nil)
; generate dollars in pair 
; https://tex.stackexchange.com/questions/75697/auctex-how-to-cause-math-mode-dollars-to-be-closed-automatically-with-electric
(electric-pair-mode)
(add-hook 'LaTeX-mode-hook
          '(lambda ()
            (define-key LaTeX-mode-map (kbd "$") 'self-insert-command)))


;; Reftex customizations
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)            ; Integrate RefTeX with AUCTeX.
;; So RefTeX knows where to look when not in a .tex file.
(setq reftex-default-bibliography
      (quote
       ("~/srikara_personal_files/emacs_stuff/bibfiles/njhigham.bib"
        "~/srikara_personal_files/emacs_stuff/bibfiles/sri_research_papers.bib")))
(setq reftex-bibpath-environment-variables (quote ("BIBINPUTS" "TEXBIB" "~/srikara_personal_files/emacs_stuff/bibfiles")))

(setq reftex-ref-macro-prompt nil) ; No prompt for ref type (new to 24.3).
;; Specifying how AUCTeX creates labels for these environments.
;; Note that refs to eq* envs set to use \eqref.
(setq reftex-label-alist
'(
("algorithm"   ?a "alg."  "~\\ref{%s}" t   ("Algorithm"))
("corollary"   ?c "cor."  "~\\ref{%s}" t   ("Corollary"))
("definition"  ?d "def."  "~\\ref{%s}" nil ("Definition" "Definitions"))
(nil           ?e ""      "~\\eqref{%s}" nil nil )  ; equation, eqnarray
(nil           ?i ""      "~\\ref{%s}" nil nil )  ; item
("example"     ?z "ex."   "~\\ref{%s}" t   ("Example" "Examples"))
("figure"      ?f "fig."  "~\\ref{%s}" t   ("Figure" "Figures"))
("lemma"       ?l "lem."  "~\\ref{%s}" t   ("Lemma"))
("assumption"  ?m "ass."  "~\\ref{%s}" t   ("Assumption"))
("problem"     ?x "prob." "~\\ref{%s}" t   ("Problem"))
("proposition" ?p "prop." "~\\ref{%s}" t   ("Proposition"))
("code"        ?n "line." "~\\ref{%s}" nil nil) ;; Doesn't work!
(nil           ?s "sec."  "~\\ref{%s}" nil nil)
("table"       ?t "table."  "~\\ref{%s}" t   ("Tables" "Tables"))
("theorem"     ?h "thm."  "~\\ref{%s}" t   ("Theorem" "Theorems"))
	)
)
(setq reftex-insert-label-flags (quote ("s" "seftacihlpz")))

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (LaTeX-add-environments
	     '("algorithm" LaTeX-env-label)
	     '("corollary" LaTeX-env-label)
	     '("definition" LaTeX-env-label)
	     '("example" LaTeX-env-label)
	     '("lemma" LaTeX-env-label)
	     '("mylist2" nil)
	     '("problem" LaTeX-env-label)
	     '("proposition" LaTeX-env-label)
	     '("theorem" LaTeX-env-label)
	     )
	    )
	  )

(setq LaTeX-eqnarray-label ""
      LaTeX-equation-label ""
      LaTeX-figure-label "fig"
      LaTeX-table-label "table"
      LaTeX-indent-level 0  ; default 2
      LaTeX-item-indent 0   ; default 2
)

;; Path to major bibfiles I use
(setq bibtex-completion-bibliography
      '("~/srikara_personal_files/emacs_stuff/bibfiles/njhigham.bib"
        "~/srikara_personal_files/emacs_stuff/bibfiles/sri_research_papers.bib"))

;; Hotkeys to insert created and updated
(defun my-bibtex-mode-hook ()
  (defun bibtex-created-date ()
    (interactive)
    (insert (format-time-string "created = \"%Y.%m.%d\",")))
  (local-set-key (kbd "C-c c") 'bibtex-created-date)
  (defun bibtex-updated-date ()
    (interactive)
    (insert (format-time-string "updated = \"%Y.%m.%d\"")))
  (local-set-key (kbd "C-c u") 'bibtex-updated-date)
  (defun mynote ()
    "Insert note field in Bib file."
    (interactive)
    (insert "note = \"Notes for future.\","))
  (local-set-key (kbd "C-c n") 'mynote)
  )
(add-hook 'bibtex-mode-hook 'my-bibtex-mode-hook)


;;Hydra keybindings
(use-package hydra
             :config
             (global-set-key (kbd "<f1>")   'hydra-work-files/body)
             (global-set-key (kbd "<f2>") 'hydra-dired/body)
             )

;; (defhydra hydra-work-files (:color blue :columns 4)
;;   "files"
;;   ("h" helm-bibtex "helm-bibtex")
;;   ("r"
;;    (lambda () (interactive) (find-file "~/Dropbox/ToRead/Sri_Read_Repo.bib"))
;;    "read-repo")
;;   ("m"
;;    (lambda () (interactive) (find-file "~/Dropbox/Master_bib_file/sri_research_papers.bib"))
;;    "master-bib")
;;   ("c"
;;    (lambda () (interactive) (find-file "~/Dropbox/MyComputer/srikara_academic_cv/srikara_CV.tex"))
;;    "academic-CV")
;;   ("e"
;;    (lambda () (interactive) (find-file "~/Dropbox/emacs_stuff/init-local.el"))
;;    "init-local")
;;   ("a"
;;    (lambda () (interactive) (find-file "~/Dropbox/emacs_stuff/abbrev_defs"))
;;    "abbrev_defs")
;;   ("x"
;;    (lambda () (interactive) (switch-to-buffer "*scratch*"))
;;    "scratch*")
;;   ("t"
;;    (lambda () (interactive) (switch-to-buffer "*text*"))
;;    "text*")
;;   ("z" scratch)
;;   )

;; (defhydra hydra-dired (:color blue :columns 4)
;;    "dired"
;;   ("1"
;;    (lambda () (interactive) (dired "~/Dropbox"))
;;    "main-dropbox")
;;   ("2"
;;    (lambda () (interactive) (dired "~/Dropbox/Collaborations"))
;;    "collaborators")
;;   ("3"
;;    (lambda () (interactive) (dired "~/Dropbox/MyComputer"))
;;    "MyComputer")
;;   ("4"
;;    (lambda () (interactive) (dired "~/Dropbox/MyComputer/codes"))
;;    "codes")
;;   ("5"
;;    (lambda () (interactive) (dired "~/Documents/GitHub/"))
;;    "GitHub-Repos")
;; )


;; Ido mode.
;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-tramp-completion nil)
(setq ido-max-directory-size 1000000)

(setq ido-use-filename-at-point 'guess)  ;; Great on URL!
(setq ido-use-url-at-point t)
(setq ido-use-virtual-buffers t)         ;; Uses old buffers from recentf.

;; This doesn't seem to have any effect.  Time order is better, anyway?
(setq ido-file-extensions-order '(".tex" ".m" ".bib" ".txt" ".emacs"))

;; For Mac: ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; http://whattheemacsd.com/
;; Just press ~ to go home when in ido-find-file.
(add-hook 'ido-setup-hook
	(lambda ()
   ;; Go straight home
   (define-key ido-file-completion-map
   	(kbd "~")
   	(lambda ()
   		(interactive)
   		(if (looking-back "/")
   			(insert "~/")
   			(call-interactively 'self-insert-command))))))

;; To insert time and date in bib entries
;; http://ergoemacs.org/emacs/elisp_datetime.html
(defun insert-long-date ()
  "Insert a nicely formatted date string."
  (interactive)
  (insert (format-time-string "%A %B %-e, %Y")))
(global-set-key (kbd "C-c C-d l") 'insert-long-date)

(defun insert-short-date ()
  "Insert a nicely formatted date string."
  (interactive)
  (insert (format-time-string "%d-%m-%y")))
(global-set-key (kbd "C-c C-d s") 'insert-short-date)


;; To insert a default tex template when a new latex file is created
;; this code is inspired from https://bit.ly/2Q6iB1h
(define-skeleton latex-skeleton
  "Default LaTeX file initial contents."
  "Title: "
  "\\documentclass[paper=a4, fontsize=13pt]{scrartcl}\n"
  "\\usepackage[a4paper, margin=0.75in]{geometry}\n"
  "\\usepackage[english]{babel}\n"
  "\\usepackage{amsmath,amssymb,amsfonts,amsthm}\n"
  "\\usepackage{booktabs}\n"
  "\\usepackage{algorithm}\n"
  "\\usepackage{color}\n"
  "\\usepackage[noend]{algpseudocode}\n"
  "\\numberwithin{algorithm}{section}\n"
  "\\usepackage{graphicx}\n"
  "\\graphicspath{{figs/}}\n"
  "\\usepackage{subcaption}\n"
  "\\usepackage{multirow}\n"
  "\\usepackage{hyperref}\n"
  "\\hypersetup{
    colorlinks   = true,
    citecolor    = red
    }\n"
  "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
  "%% Default latex macros\n"
  "\\def\\R{\\mathbb{R}}\n"
  "\\def\\C{\\mathbb{C}}\n"
  "\\def\\kbyk{k \\times k}\n"
  "\\def\\nbyn{n \\times n}\n"
  "\\def\\mbyn{m \\times n}\n"
  "\\def\\mbym{m \\times m}\n"
  "\\def\\mbyk{m \\times k}\n"
  "\\def\\nbyk{n \\times k}\n"
  "\\def\\by{\\times}\n"
  "\\def\\l{\\lambda}\n"
  "\\def\\abs#1{|#1|}\n"
  "\\def\\Om{\\Omega}\n"
  "\\def\\om{\\omega}\n"
  "\\def\\S{\\Sigma}\n"
  "\\def\\s{\\sigma}\n"
  "\\def\\O{\\mathcal{O}}\n"
  "\\def\\eps{\\epsilon}\n"
  "\\def\\fl{\\mathrm{fl}}\n"
  "\\def\\ul{u_l}\n"
  "\\def\\ur{u_r}\n"
  "\\def\\d{\\delta}\n"
  "\\def\\a{\\alpha}\n"
  "\\def\\D{\\Delta}\n"
  "\\def\\th{\\theta}\n"
  "\\def\\g{\\gamma}\n"
  "\\DeclareMathOperator{\\rank}{rank}\n"
  "\\def\\diag{\\mathop{\\mathrm{diag}}}\n"
  "\\def\\trace{\\mathop{\\mathrm{trace}}}\n"
  "\\def\\normt#1{\\|#1\\|_2}\n"
  "\\def\\normtq#1{\\|\\,#1\\,\\|_2}\n"
  "\\def\\norm#1{\\|#1\\|}\n"
  "\\def\\normi#1{\\|#1\\|_1}\n"
  "\\def\\normo#1{\\|#1\\|_{\\infty}}\n"
  "\\def\\normF#1{\\|#1\\|_{F}}\n"
  "\\def\\pinv#1{#1^{#1}}\n"
  "\\def\\chop{\\texttt{chop}}\n"
  "\\def\\mean{\\mathbb{E}}\n"
  "\\def\\t#1{\\texttt{#1}}"
  "\n\n"
  "%%%%%% Set up lemma environment and its numbering.\n"
  "\\newtheorem{lemma}{Lemma}[section]\n"
  "\\def\\proof{\\par{\\bf Proof}. \\ignorespaces}\n"
  "\\def\\qedsymbol{\\vbox{\\hrule\\hbox{%\n"
  "\\vrule height1.3ex\\hskip0.8ex\\vrule}\\hrule}}\n"
  "\\def\\endproof{\\qquad\\qedsymbol\\medskip\\par}\n"
  "\\newtheorem{theorem}{Theorem}[section]\n"
  "%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
  "\n\n"
  "%  If using amsmath use this instead:\n"
  "\\makeatletter\n"
  "\\def\\mymatrix#1{\\null\\,\\vcenter{\\normalbaselines\\m@th\n"
  "\\ialign{\\hfil$##$\\hfil&&\\quad\\hfil$##$\\hfil\\crcr\n"
  "\\mathstrut\\crcr\\noalign{\\kern-\\baselineskip}\n"
  "#1\\crcr\\mathstrut\\crcr\\noalign{\\kern-\\baselineskip}}}\\,}\n"
  "\\makeatother\n"
  "\\def\\bmatrix#1{\\left[ \\mymatrix{#1} \\right]}\n"
  "\n\n\n"
  "\\newenvironment{spr}{\\begin{quote}\\small\\sffamily{\\color{red}$\\diamondsuit$~SP~}}{\\end{quote}}\n"
  "\\numberwithin{equation}{section}\n"
  "\\numberwithin{figure}{section}\n"
  "\\numberwithin{table}{section}\n"
  "\\title{ "str | " ENTER TITLE HERE " "}\n\n"
  "\\author{Srikara Pranesh%
    \\thanks{%
    Department of Mathematics,
    University of Manchester,
    Manchester, M13 9PL, UK
    (\\texttt{srikara.pranesh@manchester.ac.uk}).
    }
    }\n"
  "\\date{\\today}\n"
  "\\begin{document}\n"
  "\\maketitle\n\n"
  ""_"\n\n"
  "\\bibliographystyle{myplain2-doi}\n"
  "\\bibliography{strings,njhigham}\n"
  "\\end{document}\n")

(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-query nil)
(setq auto-insert-alist 
      '(("\\.tex$" . latex-skeleton)))

;; To insert a default tex template for latex algorithms
(define-skeleton latex-algorithm-skeleton
  "Default LaTeX algorithm skeleton."
  "lable: "
  "%%\n"
  "\\begin{algorithm}\n"
  "\\caption{}\\label{"str | " alg. " "}\n"
  "\\begin{algorithmic}[1]\n"
  ""_"\n\n"
  "\\end{algorithmic}\n"
  "\\end{algorithm}\n"
  "%%\n")

;; To insert basic C++ skeleton
(define-skeleton cpp-skeleton
  "Default CPP code skeleton."
  "Comment: "
  "//"str |" "\n"" 
  "#include <iostream>\n"
  "using namespace std;\n"
  "int main() { \n"
  ""_"\n\n"
  "return 0;\n"
  "}\n")

;; Abbrev mode
;; turn on abbrev mode globally
(setq-default abbrev-mode t)
(setq save-abbrevs 'silently) ;autosave abbrevs
(setq abbrev-file-name "~/srikara_personal_files/emacs_stuff/abbrev_defs")
;; delete the additional space
;; code from http://ergoemacs.org/emacs/emacs_abbrev_mode_tutorial.html
(defun xah-abbrev-h-f ()
  "Abbrev hook function, used for `define-abbrev'.
 Our use is to prevent inserting the char that triggered expansion. Experimental.
 the “ahf” stand for abbrev hook function.
Version 2016-10-24"
  t)
(put 'xah-abbrev-h-f 'no-self-insert t)


;; Turn flyspell on
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; This has to be the last line of this configuration file
(provide 'init-local)
