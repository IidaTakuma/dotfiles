#!/bin/bash

echo 'Checking has been install homebrew...'
if [ which brew > /dev/null 2>&1 ]; then
    echo 'installing homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Running brew doctor...'
which brew > /dev/null 2>&1 && brew doctor

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
for tap in $taps; do
    brew tap $tap
done

# install formulas
formulas=(
    ffmpeg
    figlet
    fish
    httpie
    imagemagick
    postgresql
    pyenv
    rbenv
    yarn
)

echo 'Running brew install formulas...'
for formula in $formulas; do
    brew install $formula || brew upgrade $formula
done

# install casks
casks=(
    discord
    docker
    google-chrome
    ngrok
    postman
    slack
    visual-studio-code
    zoom
)

echo 'Running brew install casks...'
for cask in $casks; do
    brew install --cask $cask
done

brew cleanup

echo 'brew install finished'
