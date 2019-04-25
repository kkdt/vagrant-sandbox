#!/bin/bash
#
# Copyright 2017 kkdt
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

echo "Installing git from yum"
sudo yum -y install git
sudo updatedb

gitcompletion=$(locate git-completion.bash)
if [ -z "$gitcompletion" ]; then
  echo "git-completion.bash file not found"
  exit 1
fi
sudo chmod 755 $gitcompletion

gitprompt=$(locate git-prompt.sh)
if [ -z "$gitprompt" ]; then
  echo "git-prompt.sh file not found"
  exit 1
fi
sudo chmod 755 $gitprompt

globalsource=/etc/profile.d/$(hostname -s).sh
touch $globalsource
chmod 755 $globalsource

echo "Setting up global git environment"
echo "source $gitcompletion" >> $globalsource
echo "source $gitprompt" >> $globalsource
echo "export GIT_PS1_SHOWDIRTYSTATE=1" >> $globalsource
echo "export GIT_PS1_SHOWSTASHSTATE=1" >> $globalsource
echo "export GIT_PS1_SHOWUPSTREAM=\"auto\"" >> $globalsource
echo "export GIT_PS1_SHOWCOLORHINTS=1" >> $globalsource
echo "PROMPT_COMMAND='__git_ps1 \"[\u@\h]:\w\" \"\\\$ \"'" >> $globalsource
