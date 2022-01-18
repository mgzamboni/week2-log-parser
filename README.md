# Install instructions

## Install RVM and Ruby

### Pre-requisites

You need `software-properties-common` installed in order to add `PPA` repositories.

If **not** installed, open a terminal (`Ctrl+Alt+T`) and run:

```term
sudo apt-get install software-properties-common
```

### 1. Add the PPA and install the package

Open a terminal (`Ctrl+Alt+T`) and run:

```term
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
```

Add your user to `rvm` group (`$USER` will automatically insert your username):

```term
sudo usermod -a -G rvm $USER
```    
### 2. Change your terminal window

Now, in order to always load rvm, change the Gnome Terminal to always perform a login.

At terminal window, click `Edit` > `Profile Preferences`, click on `Title and Command` tab and check `Run command as login shell`.

### 3. Reboot

A lot of changes were made (scripts that needs to be reloaded, you're now member of `rvm` group) and in order to properly get all them working, you need to reboot (in most cases a logout/login is enough, but in some Ubuntu derivatives or some terminal emulators, a shell login is not performed, so we advise to reboot).

### 4. Enable local gemsets

Now enable local gemsets. Open a terminal (`Ctrl+Alt+T`) and run:

```term
rvm user gemsets
```

### 5. Install a ruby

Now you're ready to install rubies. Open a terminal (`Ctrl+Alt+T`) and run:

```term
rvm install ruby
```
```

You''ll need ruby 3.1.0 to run this project. First, check your ruby version using the command:

```term
ruby -v
```
```

##

If your version is different from the mentioned earlier, you'll need to update your ruby. To do that run the following commands:

```term
rvm install 3.1.0
rvm use 3.1.0 --default
```
```

## Installing the Bundler

You'll need to install the bundler environment that will be used to track and install the gems:

```term
gem install bundler
```
```

## Using the RSpec

To use the RSpec, you'll need to run the following command on your terminal:

```term
bin/rspec
```
```

##
