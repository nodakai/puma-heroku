
# encoding: utf-8

require 'erb'

run lambda {|env|
    req = Rack::Request.new env

    case req.path
    when '/'
        Rack::Response.new {|r| r.redirect('/home') }
    when '/home'
        html = ERB.new(<<-EOS).result(binding)
<!doctype html>
<html lang="ja">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/vnd.microsoft.icon" href="/favicon.ico" />
        <title>プーマが動いています。</title>
    </head>
    <body>
        <h1><a href="//puma-heroku.herokuapp.com">ヘロク</a>で<a href="//puma.io/">プーマ</a>が動いています。</h1>
        <p>現在 <%= Time.new.to_s %></p>
        <ul>
        <li><a href="/">/ (root)</a></li>
        <li><a href="/plain">/plain</a></li>
        <li><a href="/try404">/try404</a></li>
        </ul>
    </body>
</html>
        EOS

        Rack::Response.new html
    when '/plain'
        body = 'こんにちは、ヘロクとプーマ。'
        [200, {'Content-Type' => 'text/plain', 'Content-Length' => body.bytesize.to_s }, [body]]
    when '/favicon.ico'
        dat = File.binread('favicon.ico')
        [200, {'Content-Type' => 'image/x-icon', 'Content-Length' => dat.bytesize.to_s }, [dat]]
    else
        Rack::Response.new('見つかりません', 404, 'Content-Type' => 'text/plain; charset=UTF-8')
    end
}
