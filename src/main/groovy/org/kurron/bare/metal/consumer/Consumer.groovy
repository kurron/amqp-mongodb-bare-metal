package org.kurron.bare.metal.consumer

import groovy.util.logging.Slf4j
import org.springframework.amqp.core.Message
import org.springframework.amqp.core.MessageListener
import org.springframework.amqp.rabbit.annotation.RabbitListener
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.ConfigurableApplicationContext
import org.springframework.data.mongodb.core.MongoOperations

import java.time.Duration
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicLong

/**
 * Processes messages.
 */
@Slf4j
class Consumer implements MessageListener {

    AtomicInteger counter = new AtomicInteger( 0 )
    AtomicLong start = new AtomicLong( 0 )
    AtomicLong now = new AtomicLong( 0 )
    AtomicLong duration = new AtomicLong( 0 )

    @Autowired
    ApplicationProperties configuration

    @Autowired
    private MongoOperations theTemplate

    @Autowired
    private ConfigurableApplicationContext theContext

    @Override
    @RabbitListener( queues = 'bare-metal-consumer' )
    void onMessage( Message message ) {
        // only store the first timestamp
        start.compareAndSet( 0, System.currentTimeMillis() )
        now.set( System.currentTimeMillis() )
        def numberOfMessagesProcessed = counter.incrementAndGet()

        def model = createModel( message )
        theTemplate.insert( model )

        def durationMillis = duration.updateAndGet({ now.get() - start.get() } )
        def durationISO = Duration.ofMillis( durationMillis )
        0 == numberOfMessagesProcessed % configuration.modvalue ? log.info( '{} messages has taken {} to process', numberOfMessagesProcessed, durationISO as String ) : ''

        if ( numberOfMessagesProcessed == configuration.expectedMessageCount ) {
            log.info( '{} messages has taken {} to process', numberOfMessagesProcessed, durationISO as String )
            theContext.close()
        }
    }

    private static Model createModel( Message message ) {
        new Model( primaryKey: UUID.fromString( message.messageProperties.messageId ), timestamp: message.messageProperties.timestamp,  randomBytes: message.body )
    }
}
