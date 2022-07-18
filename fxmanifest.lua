-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })

shared_script('');

server_scripts({
    'server/**.lua',
    '@mysql-async/lib/MySQL.lua',
});

client_scripts({
    'client/**.lua'
});