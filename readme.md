# A TiddlyWiki fork with the `get-pinboard-bookmarks` plugin suited for deployment to an AWS EC2 instance.

You can easily [view the differences between this fork and the upstream project](https://github.com/Jermolene/TiddlyWiki5/compare/master...moderatemisbehaviour:master).

1. Launch a **t2.micro** instance from the **Ubuntu Server 16.04 LTS** AMI.
2. Add an EBS volume to hold the tiddlers and uncheck *delete on termination*.
3. SSH into the instance (right click on the instance and select *Connect* for instructions).
4. `cd /opt`
5. `chown --recursive ubuntu:ubuntu TiddlyWiki5/`
6. `cd TiddlyWiki5/`
7. `git clone https://github.com/moderatemisbehaviour/TiddlyWiki5.git`
8. `git submodule init`
9. `git submodule update`
10. [Format and mount the EBS volume you created earlier](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html) to `/var/tiddlers/`.
11. `chown --recursive ubuntu:ubuntu /var/tiddlers/`
12. Add Pinboard API token as an environment variable.
    * sudo nano `/etc/environment`
    * Add a new line: `pinboard_api_token=`*your_pinboard_api_token*
    * Reboot the system from the EC2 web console.
13. [Install **Node.js**](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions).
14. `cd /opt/TiddlyWiki5/`
15. `npm start`
