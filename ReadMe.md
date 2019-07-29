# Java SSL Helper

A set of scripts to help configuring Java to trust a self-signed SSL certificate.

This is commonly necessary in development environments and the procedure is arcane enough that I wrote these scripts to automate the process.

## Script Usage

### Build

Some of these scripts require some additional artifacts to be built first, run `prepDockerImage.sh` to build these.  This will include created a Docker image that can be deployed in a container orchestration environment e.g. Kubernetes to debug SSL in cloud environments.

### Testing whether Java can connect to a URL

To check whether you need to do anything you can first use `runJavaTest.sh` to try connecting to the URL of interest e.g.

    ./runJavaTest.sh http://example.org
    
If this succeeds then you will get a simple message like so:

    Successfully read 1,270 bytes from URL
    
If this fails a giant stack trace will get dumped.

### Obtaining the Certificate Key

Firstly you need to run the `grab-cert.sh` script to obtain the certificate key:

    ./grab-cert.sh host > example.cert

If the host is using SSL on a non-standard port (the default is 443) you can specify it like so:

    ./grab-cert.sh host 1234 > example.cert

### Installing and Trusting the Certificate

After this script has run you can then run the `install-cert.sh` script to install and trust the certificate key:

    ./install-cert.sh example.cert my-key

This will attempt to install the key containing in `example.cert` into your system JVM key store under the alias `my-key`.  Note that this requires `sudo` because typically the JVM key store is in an area of the file system owned by root so you may receive a password prompt to grant sudo privileges.

Also note that the script assumes a Mac OS X based JVM which uses a key store password of `changeit`, this may vary by OS and JVM (for example some installations use `changeme` as a password) so you can specify the key store password like so:

    ./install-cert.sh example.cert my-key password

Alternatively if you don't have `sudo` privileges on the system you are trying to install the key on then you can use the `install-cert-local.sh` script instead which only installs the key to your local `.keystore` file which will be in your home directory e.g.

    ./install-cert-local.sh example.cert my-key

# License

These scripts are in part based upon scripts by Paul Heinlein found in the [OpenSSL Command-Line HOW TO][1] which is under a [CC-BY-NC-SA][2] license.

Therefore these scripts are also licensed to you under the [CC-BY-NC-SA][2] license, please attribute Paul and myself (Rob Vesse) in any downstream projects.

[1]: http://www.madboa.com/geek/openssl/#cert-retrieve
[2]: http://creativecommons.org/licenses/by-nc-sa/3.0/