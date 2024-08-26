import discord, redis
from discord.ext import commands
import redis.client
from asyncio import run
from os import getenv

pod_index = getenv("POD_INDEX")
pod_index = int(pod_index) if pod_index else None

bot = commands.Bot(
    command_prefix="!", shard_id=pod_index, shard_count=3, intents=discord.Intents.all()
)

redis_client = redis.Redis("redis", 6379)


@bot.command()
async def counter(ctx: commands.Context):
    redis_client.incr("counter")
    await ctx.send(
        f"Counter: {int(redis_client.get('counter'))}\n"
        + f"Shard ID: {ctx.guild.shard_id if ctx.guild else 0}\n"
        + f"Pod Index: {pod_index or 'Not running in Kubernetes'}"
    )


run(bot.run(getenv("DISCORD_TOKEN")))
