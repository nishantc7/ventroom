from django.db import models

# Create your models here.
class Message(models.Model):
    username = models.CharField(max_length=225)
    room = models.CharField(max_length=225)
    content = models.TextField()
    date_added = models.DateTimeField(auto_now_add=True)
    sentiment = models.CharField(max_length=10,default="pass")
    class Meta:
        ordering = ('date_added',)