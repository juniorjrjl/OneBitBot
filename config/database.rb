configure :test do
    set :database, {
        adapter: 'postgresql',
        encoding: 'utf8',
        database: 'onebitbot_test',
        pool: 5,
        username: 'postgres',
        password: 'postgres',
        host: 'postgres'
    }
end

configure :development do
    set :database, {
        adapter: 'postgresql',
        encoding: 'utf8',
        database: 'onebitbot_development',
        pool: 5,
        username: 'postgres',
        password: 'postgres',
        host: 'postgres',
    }
end

configure :production do
    set :database, {
        adapter: 'postgresql',
        host: db.host,
        username: db.username
        password: db.password,|
        database: db.path[1.. -1],
        encoding: 'utf8'
    }
end