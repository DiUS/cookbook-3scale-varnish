maintainer       "Tal Rotbart"
maintainer_email "tal@springsense.com"
license          "Apache 2.0"
description      "Installs/Configures 3scale on varnish"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends          "apt"
depends          "varnish"
depends          "build-essential"

%w{debian ubuntu}.each do |os|
  supports os
end
