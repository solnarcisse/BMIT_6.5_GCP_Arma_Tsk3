#!/usr/bin/env bash
set -euxo pipefail

apt-get update -y
apt-get install -y apache2 curl jq

# Instance metadata
METADATA_HEADER="Metadata-Flavor: Google"
NAME=$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/name)
ZONE=$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/zone | awk -F/ '{print $NF}')
MTYPE=$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/machine-type | awk -F/ '{print $NF}')
IPINT=$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip)

# Custom vars from metadata
FULL_NAME="$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/attributes/full_name)"
AMOUNT="$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/attributes/annual_amount)"
THANKS="$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/attributes/thanks_person)"
BG_URL="$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/attributes/peaceful_bg_url)"
PROMO_URL="$(curl -s -H "$METADATA_HEADER" http://metadata/computeMetadata/v1/instance/attributes/promo_img_url)"

# Pull images
mkdir -p /var/www/html/assets
[ -n "$BG_URL" ]    && curl -fsSL "$BG_URL"    -o /var/www/html/assets/bg.jpg || true
[ -n "$PROMO_URL" ] && curl -fsSL "$PROMO_URL" -o /var/www/html/assets/promo.jpg || true

# Apache index with custom font, top-left resource info, line with salary, bg image, centered promo
cat >/var/www/html/index.html <<'EOF'
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>Member VM</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
<style>
  body {
    margin:0; padding:0;
    font-family: 'Montserrat', sans-serif;
    background: #111 url('/assets/bg.jpg') no-repeat center center fixed;
    background-size: cover;
    color:#f3f3f3;
  }
  .resource {
    position: fixed; top:10px; left:10px; 
    background: rgba(0,0,0,0.45); padding:12px 16px; border-radius:12px;
    line-height:1.35;
  }
  .center {
    display:flex; align-items:center; justify-content:center; height:100vh;
    text-align:center; flex-direction:column; gap:24px;
  }
  img.promo { max-width:60vw; max-height:60vh; object-fit:contain; border-radius:12px; box-shadow:0 10px 28px rgba(0,0,0,0.4); }
  .callout { font-size:1.25rem; }
</style>
</head>
<body>
  <div class="resource">
    <div><strong>Name:</strong> __NAME__</div>
    <div><strong>Zone:</strong> __ZONE__</div>
    <div><strong>Machine:</strong> __MTYPE__</div>
    <div><strong>IP:</strong> __IPINT__</div>
  </div>
  <div class="center">
    <h1>Hello from __FULL_NAME__</h1>
    <div class="callout">I, __FULL_NAME__, will make __AMOUNT__ per year thanks to Theo and __THANKS__!</div>
    <img class="promo" src="/assets/promo.jpg" alt="Favorite promo">
  </div>
</body>
</html>
EOF

# Fill in live values
sed -i "s/__NAME__/$NAME/g; s/__ZONE__/$ZONE/g; s/__MTYPE__/$MTYPE/g; s/__IPINT__/$IPINT/g" /var/www/html/index.html
sed -i "s/__FULL_NAME__/$FULL_NAME/g; s/__AMOUNT__/$AMOUNT/g; s/__THANKS__/$THANKS/g" /var/www/html/index.html

systemctl enable apache2
systemctl restart apache2
