#!/bin/bash

certbot renew --force-renew
nginx -s stop
nginx
