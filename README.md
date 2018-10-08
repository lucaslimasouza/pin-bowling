# README

## Pin-Bownling
An a command-line application to score a game of ten-pin bowling.

## Installation Instructions

You will require [Ruby](https://www.ruby-lang.org/en/downloads/) installed to use this program. (ruby 2.4.1p111 (2017-03-22 revision 58053))

If you don't have bundler installed you will have to do so with `gem install bundle`.
And then run command below to install project dependencies.

```sh
$ bundle install
```

## To run script

You can check the result run the command below:

```sh
ruby script/play.rb data/bowling-game.txt

```

## To run tests

The tests were defined with Rspec so to get the tests run command below

```sh
$ rspec
```
