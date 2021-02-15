import os

paths = os.getenv('OUT_PATHS').split()
argv = 'nix', 'store', 'sign', '--key-file', '/etc/nix/key.private', *paths
os.execvp('nix', argv)
