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
15. Start the server. There are several ways to do this..
    1. Run `npm start`. This will run the TiddlyWiki command and put it into the background with the `&` operator, but the process will be killed when the parent shell ends, which can be a problem particularly if you have used SSH to connect to a server, as the session will eventually timeout and the shell will be killed.
    2. You can run the `restart-server.sh` script to start the server. But the intention is that this script is called by a cron job on a schedule, as it looks for a *pid* file for a process id to kill before starting the server. The main advantage of this is that the `get-pinboard-bookmarks` plugin will get updated pinboard tiddlers, as it only updates on server start currently.
        1. `sudo touch /var/run/tiddlywiki.pid`
        2. `sudo chmod a+w /var/run/tiddlywiki.pid`
        3. `crontab -e`
        4. Add a new line below the comments `0 0 */1 * * /opt/TiddlyWiki5/restart-server.sh`. The server will now be restarted everyday at midnight...
        5. But you want the server running right now too, so just call the script manually `./restart-server.sh`.
        6. Output from the server can be found in `nohup.out`.
