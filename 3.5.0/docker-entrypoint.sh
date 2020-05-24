#!/bin/bash
set -e

if [[ "$1" == "next-cli" || "$1" == "nextd" ]]; then
	mkdir -p "$NEXT_DATA"

	cat <<-EOF > "$NEXT_DATA/next.conf"
	printtoconsole=1
	rpcallowip=::/0
	rpcusername=${NEXT_RPC_USERNAME:-username}
	rpcpassword=${NEXT_RPC_PASSWORD:-password}
	EOF
	chown next:next "$NEXT_DATA/next.conf"

	# ensure correct ownership and linking of data directory
	# we do not update group ownership here, in case users want to mount
	# a host directory and still retain access to it
	chown -R next "$NEXT_DATA"
	ln -sfn "$NEXT_DATA" /home/next/.next
	chown -h next:next /home/next/.next

	exec gosu next "$@"
else
	exec "$@"
fi
