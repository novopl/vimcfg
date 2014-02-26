#!/usr/bin/env python2
# -*- coding: utf-8
import re
import os
import os.path
from collections import namedtuple

Plugin        = namedtuple( 'Plugin', 'mode name repo' )
mkpath        = lambda x: x
g_configPath  = mkpath('plugins.conf')
g_reposPath   = mkpath('plugins')
g_pluginsPath = mkpath('vim/bundle')

#-----------------------------------------------------------------------------//
def load_config( path ):
  plugins = []
  with open( path ) as fp:
    for line in fp.readlines():
      #m = regex.match( line )
      m = re.match(r'(?P<mode>[+-^])(?P<name>[a-z\d_-]+)\s+:\s+(?P<repo>[^\s]+)',
          line
      )

      if m:
        plugins.append( Plugin(
          m.group('mode'),
          m.group('name'),
          m.group('repo'),
        ))
  return plugins

#-----------------------------------------------------------------------------//
def sync_plugins():
  plugins = load_config( g_configPath )

  # Check if we have a submodule temp dir
  if not os.path.exists( g_reposPath ):
    os.makedirs( g_reposPath )

  # Check if we have the plugin directory
  if not os.path.exists( g_pluginsPath ):
    os.makedirs( g_pluginsPath )


  # Add submodules if they don't exist
  newRepos = False
  for plugin in plugins:
    repoPath = os.path.join( g_reposPath, plugin.name )
    if plugin.mode != '^' and not os.path.exists( repoPath ):
      newRepos = True
      print("-- Adding plugin "+plugin.name)
      os.system('git submodule add {0} {1}'.format( plugin.repo, repoPath ))

    if plugin.mode == '^' and os.path.exists( repoPath ):
      print("-- Deleting plugin "+plugin.name)
      os.system('git submodule deinit -f {0}'.format( repoPath ))
      os.system('git rm -f {0}'.format( repoPath ))

  if newRepos:
    print("-- Initializing new plugins")
    os.system('git submodule update --init --recursive')

  # Enable/disable plugins
  for plugin in plugins:
    abspath, join = os.path.abspath, os.path.join
    repoPath      = abspath( join( g_reposPath, plugin.name ) )
    pluginPath    = abspath( join( g_pluginsPath, plugin.name ) )

    if plugin.mode == '+' and not os.path.exists( pluginPath ):
      print("-- Enabling "+plugin.name)
      os.symlink( repoPath, pluginPath )
    if plugin.mode == '-' and os.path.exists( pluginPath ):
      print("-- Disabling "+plugin.name)
      os.remove( pluginPath )


if __name__ == '__main__':
  sync_plugins()




