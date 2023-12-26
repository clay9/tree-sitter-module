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

if [ -z "${JOBS:-}" ]
then
    for language in "${languages[@]}"
    do
        ./build.sh "${language}"
    done
else
    printf "%s\n" "${languages[@]}" | xargs -P"${JOBS}" -n1 ./build.sh
fi

# push to target
cd ../target
git config user.name github-actions
git config user.email github-actions@github.com
git rm -rf --ignore-unmatch .  > /dev/null
cp -RfL ../master/dist/* .
git add -f .
git commit -m "Auto Build $(date +'%Y-%m-%d')"
git push

cd ..
