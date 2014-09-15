import pika, sys

credentials = pika.PlainCredentials("guest", "guest")
conn_params = pika.ConnectionParameters("localhost", credentials = credentials)
conn_broker = pika.BlockingConnection(conn_params)
channel     = conn_broker.channel()     # Obtain a channel to communicate with RabbitMQ

# declare a exchange where you message will be sent to
channel.exchange_declare(exchange="hello-exchange", type="direct",
                        passive=False,
                        durable=True,
                        auto_delete=False)

msg                     = sys.argv[1]
msg_props               = pika.BasicProperties()
msg_props.content_type  = "text/plain"  # create plaintext message
channel.basic_publish(body=msg,
                        exchange="hello-exchange",
                        properties=msg_props,
                        routing_key="hola")

