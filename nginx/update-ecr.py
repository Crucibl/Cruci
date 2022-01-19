#!/usr/bin/env python3
import boto3
import click
import docker

@click.command()
@click.option("--registry", help="Name of the ECR registry", required=True)

sess = boto3.Session()
resp = sess.client('ecr').get_authorization_token()
token = resp['authorizationData'][0]['authorizationToken']
token = base64.b64decode(token).decode()
username, password = token.split(':')
auth_config = {'username': username, 'password': password}
ecr_repo = resp['authorizationData'][0]['proxyEndpoint'].strip('https://')
client = docker.from_env()
client.login(username, password, ecr_repo)

def build(client, tag):
    response = [line for line in client.build(path='.', tag=registry)]
    return response

def push(client, tag):
    response = [line for line in client.push(registry)
    return response

if __name__ == "__main__":
    build()
    push()
