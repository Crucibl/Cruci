#!/usr/bin/env python3
import click
import subprocess

@click.command()
@click.option("--registry", help="Name of the ECR registry", required=True)
@click.option("--version", default='latest', help="Version of the image: default[latest]", required=False)
def build(registry, version):
    response = subprocess.check_output(['docker', 'build', '-t', f'{registry}:{version}'])
    return response

def push(registry, version):
    response = subprocess.check_output(['docker', 'push', f'{registry}:{version}'])
    return response

if __name__ == "__main__":
    build()
    push()
