# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# this is to let ~/.bashrc know if it's loaded before or after ~/.profile
# it's needed for compatibility with WSL which doesn't automatically load
# ~/.profile
export PROFILE_LOADED=true

# if we're on WSL, then ~/.profile isn't loaded automatically, instead it's
# done manually in ~/.bashrc (which IS loaded automatically (that's where
# $WSL came from))
if [ "$WSL" != true ] || [ "$BASHRC_LOADED" != true ]; then
  # if running bash
  if [ -n "$BASH_VERSION" ]; then
      # include .bashrc if it exists
      if [ -f "$HOME/.bashrc" ]; then
          . "$HOME/.bashrc"
      fi
  fi
fi

if [ -d ~/miniconda3 ]; then
  # this is for pyvenv in spacemacs (in the python layer)
  export WORKON_HOME="$HOME/miniconda3/envs"

  . /home/rihards/miniconda3/etc/profile.d/conda.sh
fi

if [ -f ~/.device_profile ]; then
  # this file isn't suposed to be commited to the Homesick castle
  . ~/.device_profile
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e /home/rihards/.nix-profile/etc/profile.d/nix.sh ]; then . /home/rihards/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

DOTNET_CLI_TELEMETRY_OPTOUT=1

if [ "$WSL" = true ]; then
  # stuff to make stuff work with VcXsrv
  export LIBGL_ALWAYS_INDIRECT=1
  export DISPLAY=:0

  if [ -x "$(command -v setxkbmap)" ]; then
    # NOTE: this is probably being called each time a terminal is opened on WSL
    setxkbmap -layout lv -variant apostrophe -model logitech_base
  fi
fi
