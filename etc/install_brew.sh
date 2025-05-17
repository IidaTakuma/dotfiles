#!/bin/bash

echo 'Checking has been install homebrew...'

which brew >/dev/null 2>&1
brew_installed=$?

if [ $brew_installed = 0 ]; then
    echo 'Homebrew has been installed'
else
    echo 'installing homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Running brew doctor...'
which brew >/dev/null 2>&1 && brew doctor

echo 'Running brew upgrade...'
brew upgrade

#install taps
taps=(
    homebrew/bundle
    homebrew/cask
    homebrew/cask-fonts
    homebrew/core
    homebrew/services
)

echo 'Running brew tap...'
for tap in ${taps[@]}; do
    brew tap $tap
done

# install formulas
formulas=(
    git
    curl
    jq
    ffmpeg
    figlet
    font-fira-code
    httpie
    imagemagick
    pyenv
    rbenv
    nodenv
    yarn
    zsh-autosuggestions
    zsh-completions
    zsh-git-prompt
)

echo 'Running brew install formulas...'
for formula in ${formulas[@]}; do
    brew install $formula || brew upgrade $formula
done

# install casks
casks=(
    discord
    docker
    google-chrome
    karabiner-elements
    ngrok
    postman
    slack
    visual-studio-code
    zoom
)

echo 'Running brew install casks...'
for cask in ${casks[@]}; do
    brew install --cask $cask
done

brew cleanup

echo 'brew install finished'
