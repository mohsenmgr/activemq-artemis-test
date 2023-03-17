const mqtt = require('mqtt')
const fs = require('node:fs');

const host = '192.168.1.162'
const port = '8883'
const clientId = '123moss'

const connectUrl = `mqtts://${host}:${port}`;

const options = {
  clientId,
  clean: true,
  connectTimeout: 4000,
  username: 'mossqt',
  password: 'mosspass',
  reconnectPeriod: 1000,

  ca: [fs.readFileSync('./server_public.pem')],

  // 'ERR_TLS_CERT_ALTNAME_INVALID'
  rejectUnauthorized: true
}

const client = mqtt.connect(connectUrl, options)

const topic = 'test/mqtt'

// error handling
client.on('error', (error) => {
  console.error(error);
  process.exit(1);
});

client.on('connect', () => {
  console.log('Connected');
  client.publish(topic, 'nodejs mqtt test', { qos: 0, retain: false }, (error) => {
    if (error) {
      console.error(error)
    }
  });
  client.end();
});
