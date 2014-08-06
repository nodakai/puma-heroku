
# encoding: utf-8

app {|env|
    body = 'こんにちは、ヘロクとプーマ。'
    [200, {'Content-Type' => 'text/plain', 'Content-Length' => body.bytesize.to_s }, [body]]
}
