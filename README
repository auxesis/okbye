okbye!
======

Simple web interface for [notmuch](http://notmuchmail.org/).

Configuring
-----------

You'll need a simple `notmuch` setup like this: 

`~/bin/fetch`

    #!/bin/bash
    
    fdm -k fetch
    notmuch new


`~/.fdm.conf`

    set maximum-size 128M
    
    action "inbox" maildir "%h/mail/inbox"
    
    account "imaps" imaps server "mail.example.org"
    user "me@example.org" pass "foobar"
    
    # send all mail to maildir action
    match all action "inbox"

Running
-------

Boot the app with: 

    shotgun 


Licence
-------
MIT Licenced
