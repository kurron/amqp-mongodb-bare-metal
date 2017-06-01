package org.kurron.bare.metal.consumer

import org.springframework.boot.context.properties.ConfigurationProperties

/**
 * Holds application properties.
 */
@ConfigurationProperties( value = 'consumer', ignoreUnknownFields = false )
class ApplicationProperties {

    String exchange
    String queue
    String routingKey
    int modvalue
}
