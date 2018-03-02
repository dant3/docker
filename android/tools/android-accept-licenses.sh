#!/usr/bin/expect -f

set timeout 1800
# set cmd [lindex $argv 0]
# set licenses [lindex $argv 1]

spawn {*}$argv
expect {
  "Accept? (*/*)" {
        exp_send "y\r"
        exp_continue
  }
  "Review licenses that have not been accepted (*/*)?" {
        exp_send "y\r"
        exp_continue
  }
  eof
}
