# Java SSL Helper

A pair of scripts to help configuring Java to trust a self-signed SSL certificate.

This is commonly necessary in development environments and the procedure is arcane enough that I wrote these scripts to automate the process.

## Script Usage

### Obtaining the Certificate Key

Firstly you need to run the `grab-cert.sh` script to obtain the certificate key:

    ./grab-cert.sh host > example.cert

If the host is using SSL on a non-standard port (the default is 443) you can specify it like so:

    ./grab-cert.sh host 1234 > example.cert

### Installing and Trusting the Certificate

After this script has run then you can the `install-cert.sh` script to install and trust the certificate key:

    ./install-cert.sh example.cert my-key

This will attempt to install the key containing in `example.cert` into your JVM key store under the alias `my-key`.  Note that this requires `sudo` because typically the JVM key store is in an area of the file system owned by root so you may receive a password prompt to grant sudo privileges.

Also note that the script assumes a Mac OS X based JVM which used the key store password of `changeit`, this may vary by OS and JVM so you can specify the key store password like so:

    ./install-cert.sh example.cert my-key password

# License

These scripts are in part based upon scripts by Paul Heinlein found in the [OpenSSL Command-Line HOW TO][1] which is under a [CC-BY-NC-SA][2]

Therefore these scripts are also licensed to you under [CC-BY-NC-SA][2] license, please attribute Paul and myself (Rob Vesse) in any downstream projects.

[1]: http://www.madboa.com/geek/openssl/#cert-retrieve
[2]: http://creativecommons.org/licenses/by-nc-sa/3.0/