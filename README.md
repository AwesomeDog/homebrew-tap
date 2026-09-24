# Homebrew Tap

Personal Homebrew tap for [@AwesomeDog](https://github.com/AwesomeDog)'s projects.

## Installation

Nothing to set up. Install with the fully qualified name and Homebrew handles the rest: it taps
this repository automatically and grants trust to the single item you named (no `brew tap` or
`brew trust` needed).

```bash
brew install --cask AwesomeDog/tap/maxlaunchpad
brew install AwesomeDog/tap/soma
```

## Available Casks

### [maxlaunchpad](https://github.com/AwesomeDog/maxlaunchpad)

A simple, reliable launcher that makes your most-used applications instantly accessible from the keyboard

```bash
brew install --cask AwesomeDog/tap/maxlaunchpad
```

## Available Formulae

### [soma](https://github.com/AwesomeDog/soma)

Local knowledge-base search engine for natural-language and keyword search

```bash
brew install AwesomeDog/tap/soma
```

### [infrss](https://awesomedog.github.io/infinite-rss-reader/)

Infinite-scrolling RSS reader for Thunderbird

```bash
brew install AwesomeDog/tap/infrss
```

### [infrss-server](https://awesomedog.github.io/infinite-rss-reader/)

Server for Infinite RSS Reader

```bash
brew install AwesomeDog/tap/infrss-server
```

## Updating

```bash
brew update
brew upgrade --cask AwesomeDog/tap/maxlaunchpad
brew upgrade AwesomeDog/tap/soma
brew upgrade AwesomeDog/tap/infrss
brew upgrade AwesomeDog/tap/infrss-server
```

## Uninstalling

```bash
brew uninstall --cask maxlaunchpad
brew untap AwesomeDog/tap
```
