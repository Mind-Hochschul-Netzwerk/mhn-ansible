#!/bin/bash
# Script to fetch vault Password from Bitwarden using BW cli

set -e

bw get password "mhn-inventory ansible vault password"
