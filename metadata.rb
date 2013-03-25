maintainer       "Takayuki SHIMIZUKAWA"
maintainer_email "shimizukawa@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures bp-redmine"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "bp-redmine", "install redmine dependencies for BePROUD."
recipe "bp-redmine::restructuredtext", "install redmine restructuredtext plugins."
recipe "bp-redmine::lockrun", "install lockrun command for avoiding cron task overrun."

depends "rvm"
depends "rvm-redmine"
depends "python"

supports "ubuntu"
