#!/bin/bash
set -e

if [[ "$1" == "next-cli" || "$1" == "nextd" ]]; then
	mkdir -p "$NEXT_DATA"

	if [[ ! -s "$NEXT_DATA/nextcoin.conf" ]]; then
		cat <<-EOF > "$NEXT_DATA/nextcoin.conf"
		daemon=0
		printtoconsole=0
		server=1
		rpcallowip=::/0
		rpcuser=${NEXT_RPC_USERNAME:-user}
		rpcpassword=${NEXT_RPC_PASSWORD:-password}
		rpcbind=0.0.0.0
		whitelist=0.0.0.0/0
		EOF
		chown nextcoin:nextcoin "$NEXT_DATA/nextcoin.conf"
	fi

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R nextcoin "$NEXT_DATA"
	ln -sfn "$NEXT_DATA" /home/nextcoin/.next
	chown -h nextcoin:nextcoin /home/nextcoin/.next

	echo "These are the contents of nextcoin.conf: "
	cat /home/nextcoin/.next/nextcoin.conf

	exec gosu nextcoin "$@"
else
	exec "$@"
fi
