# What is this?

This repository provides a few scripts that might make the exercism mentor experience a little smoother.

<img alt="satisfying" style="max-width: 100px" src="https://i.imgflip.com/2pfnon.jpg">


## Do go on....

[Exercism.io](https://exercism.io) is a great resource for programming practice. The most outstanding feature is certainly how it recruits its community to participate not just in improving and producing more exercises, but -even more importantly- to participate as mentors.

The overall mentor experience is not streamlined quite yet, but with a few hacks and scripts, it can be a lot of fun!

The routine goes:
1. Use your eyeballs to verify the code is secure enough to run on your machine
1. Download
1. Enable all tests
1. Run all tests

This project aims to automate all that at the press of a few buttons!

# What does it do?

NOTE: Currently only the JavaScript track is supported

1. The usual: It downloads a solution when provided the `exercism download --uuid...` command string
1. Lint everything (don't stop on error)
1. Security: Transpiles and sandboxes all `*.js` scripts (by replacing the original file with a VM runner)
   * By default, your mentor dashboard warns you to use your eyeballs to make sure that there is no malicious code; but I don't trust my eyes on such matters. I want things safe by default.
1. Automatically enable all extended tests (Credit goes to `loic` from the Exercism Mentor Slack Team!)
1. Finally, it runs *all* the tests! :)


# Instructions

* Go to your Exercism folder (or any other folder where you want to install this)
* Checkout this repository: `git clone...`
* `cd _MentorTools`
* `npm install`
* `chdmod +x ./bin/exc.sh`
* Run it: `./bin/exc.sh`
  * Copy&paste the `exercism download --uid=...` command from the mentor dashboard
* Bonus points: place `exc.sh` in your `$PATH` :)


## WARNING: Windows
* Not tested on Windows yet
*  At the very least, you want to make sure, you have CYGWIN (or some other minimal POSIX environment) installed
*  (HINT: I usually get it by installing git; when using the MSI installer, you can even choose to add Linux tools to your default command line)

# Troubleshooting

* Different shell (and other command) versions (e.g. `sed` and regex) can cause some pain and incompatabilities :(
   * (e.g. the default `bash` installation on MacOS Mojave is still v3.2 from 2007!)
* In case the `vm2` module vannot be found, maybe something went wrong with `npm install`, or `NODE_PATH`
   * Also check out: https://stackoverflow.com/questions/12594541/npm-global-install-cannot-find-module


# Credit

The real heroes are the people at exercism as well as the existing mentor community who relentlessly help others in their learning without expecting much (if anything) in return! Love you guys <3

Special mention: `NobbZ` who has been willing to put up with my pesky questions right from the start :)

<!-- # use zsh?
1. Install zsh (e.g. on Mac: https://www.freecodecamp.org/news/how-to-configure-your-macos-terminal-with-zsh-like-a-pro-c0ab3f3c1156/)
  * `brew cask install iterm2 && brew install zsh`
1. Add function to zsh config -->
