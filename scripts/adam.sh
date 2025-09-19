#!/bin/bash
# Update and install Apache2
apt update
apt install -y apache2

# Start and enable Apache2
systemctl start apache2
systemctl enable apache2

# GCP Metadata server base URL and header
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
METADATA_FLAVOR_HEADER="Metadata-Flavor: Google"

# Use curl to fetch instance metadata
local_ipv4=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/network-interfaces/0/ip")
zone=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/zone")
project_id=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/project/project-id")
network_tags=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/tags")
hostname_output=$(hostname -f 2>/dev/null || hostname)

# Create a custom HTML page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Armageddon No. 5,396,091</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
  <style>
    body,h1,h3 {font-family: "Raleway", sans-serif}
    body, html {height: 100%}
    .bgimg {
      background-image: url('https://preview.redd.it/gakairnc41941.png?width=1080&crop=smart&auto=webp&s=d8c38c28b32f6f15dc074bdcc1b811479354236f');
      min-height: 100%;
      background-position: center;
      background-size: cover;
    }
    .w3-display-middle {
      background-color: rgba(0, 0, 0, 0.466);
      padding: 20px;
      border-radius: 10px;
    }
    .transparent-background {
      background-color: rgba(0, 0, 0, 0.575);
      padding: 20px;
      border-radius: 10px;
    }
    .rounded-image {
      border-radius: 25px;
    }
  </style>
</head>
<body>
  <div class="bgimg w3-display-container w3-animate-opacity w3-text-white">
    <div class="w3-display-middle w3-center">
      <div style="display: flex; justify-content: center; align-items: center;">
        <iframe 
          src="https://images.squarespace-cdn.com/content/v1/5a2061aa9f8dcef02d2e19b1/1556573004192-ND747H0J323KS6555L79/group+warriors.gif"
          width="600"
          height="338"
          style="border-radius:10px;"
          frameborder="0"
          title="Promotional Media"
          allowfullscreen>
        </iframe>
      </div>
      <hr class="w3-border-grey" style="margin:auto;width:40%;margin-top:15px;">
      <h3 class="w3-large w3-center" style="margin-top:15px;">
        <a href="https://github.com/tiqsclass6/gcp-repo-assignments/blob/assignment-05312025/brazil.sh"
           class="w3-button w3-transparent w3-border w3-border-white w3-round-large w3-text-white"
           target="_blank">
          Source Code
        </a>
      </h3>
    </div>
    <div class="w3-display-bottomleft w3-padding-small transparent-background outlined-text">
      <h1>Armageddon No. 5,396,091</h1>
      <h3>"I, Adam, will make 160,000 per year thanks to Theo and El Guapo"</h3>
      <p><b>Instance Name:</b> $hostname_output</p>
      <p><b>Instance Private IP Address:</b> $local_ipv4</p>
      <p><b>Zone:</b> $zone</p>
      <p><b>Project ID:</b> $project_id</p>
      <p><b>Network Tags:</b> $network_tags</p>
    </div>
  </div>
</body>
</html>
EOF
