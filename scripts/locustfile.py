from locust import task
from locust.contrib.fasthttp import FastHttpUser


# see: https://docs.locust.io/en/stable/increase-performance.html
class User(FastHttpUser):
    @task
    def hello_world(self):
        self.client.get("/")
