export VPN_ENDPOINT="https://cphvpn.tradeshift.com/"
export VPN_OP_ITEM="fntikzwofn7vqmu43c7chfakby"
export VPN_OP_TEAM="my"

function vpn() {
  local OP_SESSION=$(printenv OP_SESSION_${VPN_OP_TEAM})
  
  # get pw and token from 1password
  if [ -n "$OP_SESSION" ]; then
    # use existing token or renew if expired
    eval $(op signin $VPN_OP_TEAM --session $OP_SESSION)
  else
    eval $(op signin $VPN_OP_TEAM)
  fi
  local VPN_PASSWORD=$(op get item $VPN_OP_ITEM --fields password)
  local VPN_USERNAME=$(op get item $VPN_OP_ITEM --fields username)
  local VPN_OTP=$(op get totp $VPN_OP_ITEM)

  echo "$VPN_PASSWORD,$VPN_OTP" | \
    sudo openconnect \
    --protocol=pulse \
    --no-dtls \
    -u $VPN_USERNAME \
    --passwd-on-stdin \
    $VPN_ENDPOINT
}
