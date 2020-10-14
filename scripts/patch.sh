#!/usr/bin/env bash

# use gnu-sed (brew install gsed)
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED=gsed
else
    SED=sed
fi

# Patches mathjax's CDN to work without having to reload:
# https://github.com/GitbookIO/plugin-mathjax/issues/34#issuecomment-513541330 
$SED -i "s/https.*/https:\/\/cdnjs.cloudflare.com\/ajax\/libs\/mathjax\/2.6.1\/MathJax.js?config=TeX-AMS-MML_HTMLorMML\',/g" ./docs/node_modules/gitbook-plugin-mathjax/index.js
