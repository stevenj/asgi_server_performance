"""Workers for uvicorn."""

from uvicorn.workers import UvicornWorker


class AsyncioH11Worker(UvicornWorker):
    CONFIG_KWARGS = {"loop": "asyncio", "http": "h11", "lifespan": "off"}


class UvloopH11Worker(UvicornWorker):
    CONFIG_KWARGS = {"loop": "uvloop", "http": "h11", "lifespan": "off"}


class AsyncioHttptoolsWorker(UvicornWorker):
    CONFIG_KWARGS = {"loop": "asyncio", "http": "httptools", "lifespan": "off"}


class UvloopHttptoolsWorker(UvicornWorker):
    CONFIG_KWARGS = {"loop": "uvloop", "http": "httptools", "lifespan": "off"}
