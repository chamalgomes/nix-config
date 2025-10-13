{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "ChamalGomesHSO";
    userEmail = "chamalgomes166@gmail.com";

    extraConfig = {
      safe.directory = config.my.home.trustedGitDirs;
      core = {
        editor = "vim";
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      };
      color.ui = "auto";
      pull.rebase = false;
      push.default = "simple";
      push.autoSetupRemote = true;
    };

    aliases = {
      st = "status";
      co = "checkout";
      ci = "commit";
      br = "branch";
      df = "diff";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      amend = "commit --amend --reuse-message=HEAD";
      undo = "reset HEAD~1 --mixed";
    };
  };
}
