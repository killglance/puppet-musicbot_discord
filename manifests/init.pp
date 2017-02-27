# Class: musicbot_discord
# ===========================
#
# Full description of class musicbot_discord here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `$user`
#  User to use for installing and running the bot
#
# * `$install_dir`
#  Directory to install the bot into
#
# * `$autojoin_chan`
#  Join a channel on startup.
#
# * `$auto_pause`
#  Enable / Disable auto-pause
#
# * `$auto_playlist`
#  Play random songs when nothing is queued.
#
# * `$auto_summon`
#  Join the channel the owner is in on startup
#
# * `$bind_to_chan`
#  Restrict which channels musicbot listens for commands on
#
# * `$command_prefix`
#  Symbol prefix for all musicbot commands
#
# * `$debug`
#  Enable / Disable debug level messages from the bot
#
# * `$default_volume`
#  The default volume
#
# * `$delete_invoke`
#  Delete the invoking message when DeleteMessages is enabled.
#
# * `$delete_msgs`
#  Delete messages that musicbot posts after a TTL
#
# * `$np_mentions`
#  Mention the user that queued the song
#
# * `$owner_id`
#  Discord ID of the owner
#
# * `$required_skip`
#  Skip votes required to skip the current track
#
# * `$save_vids`
#  Enable / Disable caching of videos after they are played
#
# * `$skip_ratio`
#  Percent of non-deafened users required to skip
#
# * `$token`
#  Discord chatbot api token
#
# * `$whitelist_check`
#  Enable / Disable whitelisting
#
# Examples
# --------
#
# @example
#    class { 'musicbot_discord':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class musicbot_discord (
  $autojoin_chan   = $::musicbot_discord::params::autojoin_chan,
  $auto_pause      = $::musicbot_discord::params::auto_pause,
  $auto_playlist   = $::musicbot_discord::params::auto_playlist,
  $auto_summon     = $::musicbot_discord::params::auto_summon,
  $bind_to_chan    = $::musicbot_discord::params::bind_to_chan,
  $command_prefix  = $::musicbot_discord::params::command_prefix,
  $debug           = $::musicbot_discord::params::debug,
  $default_volume  = $::musicbot_discord::params::default_volume,
  $delete_invoke   = $::musicbot_discord::params::delete_invoke,
  $delete_msgs     = $::musicbot_discord::params::delete_msgs,
  $install_dir     = $::musicbot_discord::params::install_dir,
  $np_mentions     = $::musicbot_discord::params::np_mentions,
  $owner_id        = $::musicbot_discord::params::owner_id,
  $required_skip   = $::musicbot_discord::params::required_skip,
  $save_vids       = $::musicbot_discord::params::save_vids,
  $skip_ratio      = $::musicbot_discord::params::skip_ratio,
  $token           = $::musicbot_discord::params::token,
  $user            = $::musicbot_discord::params::user,
  $whitelist_check = $::musicbot_discord::params::whitelist_check,
) inherits musicbot_discord::params {
  include ::stdlib

  validate_string(
    $autojoin_chan,
    $auto_pause,
    $auto_playlist,
    $auto_summon,
    $bind_to_chan,
    $command_prefix,
    $debug,
    $default_volume,
    $delete_invoke,
    $delete_msgs,
    $np_mentions,
    $owner_id,
    $required_skip,
    $save_vids,
    $skip_ratio,
    $token,
    $user,
    $whitelist_check,
  )
  validate_absolute_path($install_dir,)

  class { '::musicbot_discord::install': } ->
    class { '::musicbot_discord::config': } ~>
    class { '::musicbot_discord::service': }
}
