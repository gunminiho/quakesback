Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Aquí puedes especificar el origen que deseas permitir, como 'http://example.com'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Esto es opcional y dependerá de tus necesidades
  end
end
