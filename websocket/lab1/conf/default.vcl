vcl 4.0;
backend apache {
    .host = "apache";
    .port = "80";
}
backend flask {
    .host = "flask";
    .port = "5000";
}

sub vcl_pipe {
    if (req.http.upgrade) {
        set bereq.http.upgrade = req.http.upgrade;
	    set bereq.http.connection = req.http.connection;
    }
}
sub vcl_recv {
    if (req.url ~ "^/socket.io/") {
        set req.backend_hint = flask;
    } else {
        set req.backend_hint = apache;
    }

    if (req.http.Upgrade ~ "(?i)websocket") {
        set req.backend_hint = flask;
        return (pipe);
    }
    else {
        set req.backend_hint = apache;
    }
}