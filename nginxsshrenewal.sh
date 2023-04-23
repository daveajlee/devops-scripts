#!/bin/bash
# This is a shell script to automate the renewal of letsencrypt certificates with nginx.
# It assumes that certbot and nginx are correctly configured and takes no parameters.

certbot renew --force-renew
nginx -s stop
nginx
