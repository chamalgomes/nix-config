{ config, lib, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 1000;
    historyFileSize = 2000;
    
    shellOptions = [
      "histappend"
      "checkwinsize"
      # Uncomment the following if you want to enable advanced pattern matching
      # "globstar"
    ];

    shellAliases = {
      # Color support for various commands
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      
      # ls aliases
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";

      #Development aliases
      docker-rebuild = "docker-compose down -v && docker-compose up --build";
      gdp = "git checkout dev && git pull";
      ven = "source .venv/bin/activate";
      dven = "deactivate";

      # Alert alias for long running commands
      alert = "notify-send --urgency=low -i \"$([ $? = 0 ] && echo terminal || echo error)\" \"$(history|tail -n1|sed -e 's/^\\s*[0-9]\\+\\s*//;s/[;&|]\\s*alert$//')\"";
    };
    
    initExtra = ''
      #Create default repos dir within compute instance
      mkdir -p "${config.home.homeDirectory}/repos"
      
      # Set default directory when opening new bash sessions
      cd "${config.home.homeDirectory}/repos"

      # Set up a colored prompt based on terminal capabilities
      case "$TERM" in
          xterm-color|*-256color) color_prompt=yes;;
      esac
      
      if [ -n "$force_color_prompt" ]; then
          if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
              color_prompt=yes
          else
              color_prompt=
          fi
      fi
      
      # Load Git prompt support for PS1 branch display
      . ${pkgs.git}/share/git/contrib/completion/git-prompt.sh

      if [ "$color_prompt" = yes ]; then
          PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
      else
          PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '
      fi
      unset color_prompt force_color_prompt
      
      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*)
          PS1="\[\e]0;\u@\h: \w\a\]$PS1"
          ;;
      *)
          ;;
      esac

      # make less more friendly for non-text input files
      [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
      
      # Set variable identifying the chroot you work in (used in the prompt)
      if [ -z "''${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
          debian_chroot=$(cat /etc/debian_chroot)
      fi
      
      # Load bash aliases if present
      if [ -f ~/.bash_aliases ]; then
          . ~/.bash_aliases
      fi
      
      # Enable programmable completion features
      if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
          . /etc/bash_completion
        fi
      fi

    # Open VS Code at the current working dir
    code .

    '';
  };
  
  # If you need dircolors support
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };
  
  # For bash completion
  programs.bash.enableCompletion = true;
}
