# A Basic Apt Repository

This will create a very basic stripped down apt repository, suitable for
use with deb based Linux distributions (e.g., Debian, Ubuntu, Raspbian, etc.).

This is meant only for quick and easy "single source" repositories. It's not
intended to handle multiple branches (i.e., unstable, testing, stable). If you
need that you can make multiple clones, one per branch, or look into Debian's
more hefty scripts for creating large repositories.

But if you want something that is *quick*, *low effort* and *works*, then this
is for you.

# Getting Started

1. Clone this repository to someplace that can be served by a web server.
2. Generate a GPG key and set `GPGOPTS` in `gpg.mk`.
3. Copy `deb` files into this directory with any heirarchy you like.
4. Run `make` to generate package indices.

# Setting up hosts to use your repository

1. Add `deb http://<webserver>/path/ ./` to `/etc/apt/sources.list.d/local.list`.
2. Export your public key and run `apt-key add <filename.pub>`.
3. `apt-get update`

# Securing your credentials

Your GPG keyring or any file containing the password should **not** be in
a location that can be served by your web server!
