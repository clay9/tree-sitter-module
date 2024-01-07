#!/usr/bin/env bash

set -u
set -e

## 仅保留需要的
languages=(
    # 'bash'
    'c'
    # 'c-sharp'
    # 'clojure'
    # 'cmake'
    'cpp'
    # 'css'
    # 'scss'
    'dockerfile'
    # 'elisp'
    # 'elixir'
    # 'glsl'
    # 'go'
    # 'go-mod'
    # 'heex'
    # 'html'
    # 'janet-simple'
    # 'java'
    # 'javascript'
    # 'json'
    # 'julia'
    # 'lua'
    # 'make'
    # 'markdown'
    # 'org'
    # 'perl'
    # 'proto'
    # 'python'
    # 'ruby'
    # 'rust'
    # 'scala'
    # 'surface'
    # 'sql'
    # 'toml'
    # 'tsx'
    # 'typescript'
    # 'typst'
    # 'verilog'
    # 'vhdl'
    # 'wgsl'
     'yaml'
    # 'dart'
    # 'souffle'
    # 'kotlin'
    # 'zig'
    # 'bison'
)

# read old cfg
old_cfg=$1/cfg
if [ -f "old_cfg" ]; then
    source $old_cfg
fi

# build.sh
current=`pwd`
dist="${current}/dist"
cfg="${current}/cfg"
mkdir -p dist

for language in "${languages[@]}"
do
    ./build.sh "${language}" $dist $cfg
    cd $current
done


### push to target

# check dist is empty
if [ -z $dist ]; then
    exit 0
fi

# mv dist => target && push
cd ../target
git config user.name github-actions
git config user.email github-actions@github.com
git rm -rf --ignore-unmatch .  > /dev/null
mv ${dist}/* .
mv $cfg .
git add -f .
git commit -m "Auto Build $(date +'%Y-%m-%d')"
git push
