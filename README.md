Docker registry on a USB Flash Drive
====================================

Got big images but no direct fiber to your laptop? No problem! Just Bring Your Own Docker Registry. This is a project used to my [DockerBook](https://eyskens.me/docker-on-the-desktop/) to store large Docker images containing Windows. After brainstorming about local registry servers [Carolyn Van Slyck](http://carolynvanslyck.com/) came on the idea to just host in on a local USB Flash drive.

![Pushing a VM with Visual Studio](https://static.eyskens.me/push-win10.png)

## How to setup
The setup consists our of 2 parts in the `docker-compose.yml`, if you have never used this I suggest to look into ["Overview of Docker Compose"](https://docs.docker.com/compose/overview/).

The first part is to setup the registry.  
Here not much setup is needed. The container has 2 volumes, one contains the config files the other one the storage. The config files are quite generic and shouldn't be changed.  
For the 2nd volume you should change the path from `/media/usb0/` to where your USB drive is mounted, this may vary on the distro and desktop envoirement of your choise.  
The IP address there should not be changed unless you have a conflicting interface.

The second is the proxy.  
Should you not want a nice domain and/or local TLS you may delete the part in the compose file and add the following to the registry part.
```
ports:
  - 5000:5000
```
Which allows you to do `docker-compose up` and push images to `localhost:5000/`

But to me this seemed boring and bad looking. So I have set up Caddy. And an A record on a subdomain to `172.20.128.2`.
I used a static IP to be able to use an A record on my DNS, should I be offline an entry in `/etc/hosts` will do.  
The Dockerfile used for Caddy is provided in `./caddy`. Since this is a private IP and I don't want my registry to be exposed to the internet I used the DNS module to verify the ownership of my domain.  
In my case this was Cloudflare. If you have another DNS provider you want to use you need to change `bash -s tls.dns.cloudflare` in the Dockerfile to your provided and also change the Caddy file to match the needed configuration.  
If you do use CloudFlare you need to set the `CLOUDFLARE_EMAIL` and `CLOUDFLARE_API_KEY` in the compose file. This way Caddy can set the required records.  
The last step is to change `reg.maartje.tech` which is my domain to yours. 

Now you'll be able to run `docker-compose up` and are ready to go!



## My setup
I am using the "Lexar jumpdrive P20" ([image](https://twitter.com/MaartjeME/status/898912679624146944)) since it is the fastest (for this price range) I could find. I use CloudFlare for my DNS as meantioned above. I turn the system on and off using i3-blocks. 

## Extra <3 for i3 users
I included my script for i3-blocks under the name `i3-bar.sh`. You can toggle the state by double clicking the bar text.