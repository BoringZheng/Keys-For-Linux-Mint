# Keys For Linux Mint

This project aims to provide a easy method for Linux Mint users to simply switch their keyboard mapping. If you are interested in customized keyboards, and unfortunately you are also a Linux Mint user, I think the project would help you a lot.

## Installation
In fact, installation is very simple. The only thing you need to do is to run
``` bash
git clone https://github.com/BoringZheng/Keys-For-Linux-Mint.git
sudo ./install.sh
```

## Configuration
You could use command below to set your own configure and ``-t``is repeatable.
``` bash
sudo ./configure.sh -t [--parma]
sudo ./configure.sh -t space //Make space be a layer(nav) key.
sudo ./configure.sh -t dire //Make nav(w/a/s/d) be up/left/down/right.
sudo ./configure.sh -t control //Make Capslock be Lcontrol.
sudo ./configure.sh -t home-end //Make nav layer(q/e) be home/end.
sudo ./configure.sh -t fmap //Make nav layer(1-=) be f1-f12 
```

Portions of this software are derived from "keyd" by Raheman Vaiya, licensed under the MIT/X Consortium License.
