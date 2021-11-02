#!/bin/sh

BASE_URL="https://hub.fastgit.org/mayswind/AriaNg"
LATEST_TAG=$(curl -s "${BASE_URL}/releases/latest" | sed -En 's/.+\/tag\/([.0-9A-Za-z]+)".+/\1/;p')

# https://github.com/mayswind/AriaNg/releases/download/1.1.4/AriaNg-1.1.4-AllInOne.zip
curl -L -# -C - "${BASE_URL}/releases/download/${LATEST_TAG}/AriaNg-${LATEST_TAG}-AllInOne.zip" -o new.zip

unzip -o new.zip && rm -f new.zip

# Allow insecure protocol and disallow shutdown operation
sed -Ei 's/"https"===[A-Za-z_][0-9A-Za-z_]*\.protocol\(\)/ false/; s/ng-click="shutdown\(\)"/ng-click="shutdown\(\)" disabled="disabled"/' index.html
