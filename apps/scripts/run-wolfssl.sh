#!/bin/bash
#   -cipher -aes-cbc -aes-gcm -aes-ecb -aes-xts -aes-cfb -aes-ofb -aes-ctr \
#   -aes-ccm -aes-siv -camellia -arc4 -chacha20 -chacha20-poly1305 -des \
#   -digest -md5 -poly1305 -sha -sha2 -sha224 -sha256 -sha384 -sha512 -sha3 \
#   -sha3-224 -sha3-256 -sha3-384 -sha3-512 -shake -shake128 -shake256 -ripemd \
#   -blake2b -blake2s -mac -cmac -hmac -hmac-md5 -hmac-sha -hmac-sha224 \
#   -hmac-sha256 -hmac-sha384 -hmac-sha512 -pbkdf2 -siphash -kdf -srtp-kdf \
#   -asym
pushd wolfssl
~/scripts/run-app.sh -d -u -h /home/benshan/hotcalls-wolfssl.conf -r wolfcrypt/benchmark/.libs/benchmark -csv \
              -rsa-kg -rsa -rsa-sz -dh -ecc-kg -ecc -ecc-enc -ecc-all -curve25519-kg \
              -x25519 -ed25519-kg -ed25519 -curve448-kg -x448 -ed448-kg -ed448 -eccsi-kg \
              -eccsi-pair -eccsi-val -eccsi -sakke-kg -sakke-rsk -sakke-val -sakke \
              -other -rng
popd