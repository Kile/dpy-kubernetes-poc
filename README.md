# Proof of Concept Discord bot running in Kubernetes

This is a simple proof of concept Discord bot that runs in Kubernetes. It uses the [discord.py](https://discordpy.readthedocs.io/en/latest/) library to interact with Discord. This POC uses Redis to also demonstrate how a shared cache would work. This is demonstated by the `!counter` command that will increment a number every time it is called, no matter what pod the command is recieved by.

There are three ways you can run this bot:

## The normal way
just running `python3 main.py` will start the bot. You will need to have the `DISCORD_TOKEN` environment variable set to your bot's token. You will need to manually start a redis server to also be able to use the `!counter` command.

## Docker
You can start both Redis and the bot using `docker compose up -d --build`. This will start a Redis server and the bot in a container. You will need to have the `DISCORD_TOKEN` environment variable set to your bot's token in an `.env` file.

## Kubernetes
A convenient script `bot.sh` is provided to start the bot in Kubernetes. You will need to have a Kubernetes cluster running and `kubectl` configured to use it (if you are completely new to Kubernetes take a look at [minikube](https://minikube.sigs.k8s.io/docs/)). The script will create a namespace, a deployment and a service for the bot. You will need to have the `DISCORD_TOKEN` environment variable set to your bot's token in an `.env` file. The script has 3 commands: `up`, `down` and `restart`. `up` will create the resources, `down` will delete them and `reload` will delete and recreate them.

Using minikube, running this bot in Kubernetes is as easy as running
```sh
miniukbe start
./bot.sh up
```