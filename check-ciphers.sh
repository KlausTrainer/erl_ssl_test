#!/bin/sh

HOST=127.0.0.1
PORT=5555

erl -pa $(pwd)/ebin $(find $(pwd)/deps -type d -name ebin | xargs) \
    -s erl_ssl_test -noshell 2>/dev/null>/dev/null &
pid=$!

sleep 2

for cipher in $(openssl ciphers | perl -p -e "s/:/\n/g" | grep -vE "(EDH|SRP|PSK|EXP|SEED|CAMELLIA|GCM)"); do
    echo hello | openssl s_client -cipher $cipher -CAfile $(pwd)/priv/ssl/ca.crt -connect $HOST:$PORT 2>/dev/null>/dev/null
    if [ $? -ne 0 ]; then
        echo "works not: $cipher"
    else
        echo "works:     $cipher"
    fi
done

kill $pid
